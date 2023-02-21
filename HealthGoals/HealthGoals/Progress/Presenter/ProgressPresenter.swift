//
//  ProgressPresenter.swift
//  HealthGoals
//
//  Created by Carlos Rodriguez Asensio on 17/2/23.
//

import Foundation
import HealthKit

protocol ProgressPresenterDelegate: AnyObject {
  func presentProgress(_ progress: Progress)
  func presentAlert(title: String, message: String)
}

protocol ProgressPresenterProtocol {
  var navigationItemTitle: String { get }
  var title: String { get }
  var description: String { get }
  var goal: String { get }
  var type: String { get }
  var trophy: String { get }
  var points: String { get }
  var movement: String { get }
  
  func setViewDelegate(delegate: ProgressPresenterDelegate)
  func saveProgress(_ progress: Progress)
  func getDailySteps()
  func getDistanceWalkingRunning()
}

final class ProgressPresenter {
  // MARK: Variables
  private weak var delegate: ProgressPresenterDelegate?
  private let coreDataManager: CoreDataManagerProtocol
  private var goalProgress: Goal?
  private let healthStore = HKHealthStore()
  private var observerQuery: HKObserverQuery?
  private var query: HKStatisticsQuery?
  private var myDailyMovement: Movement?
  
  // MARK: Initializer
  init(goal: Goal? = nil, coreDataManager: CoreDataManagerProtocol) {
    goalProgress = goal
    self.coreDataManager = coreDataManager
  }
}

// MARK: - ProgressPresenterProtocol

extension ProgressPresenter: ProgressPresenterProtocol {
  var navigationItemTitle: String { "Progress" }
  
  var title: String {
    guard let goalProgress else { return "-" }
    return goalProgress.title
  }
  
  var description: String {
    guard let goalProgress else { return "-" }
    return goalProgress.description
  }
  
  var goal: String {
    guard let goalProgress else { return "-" }
    return "Goal: \(goalProgress.goal)"
  }
  
  var type: String {
    guard let goalProgress else { return "-" }
    return "Type: \(goalProgress.type)"
  }
  
  var trophy: String {
    guard let goalProgress else { return "-" }
    var trophy: String = ""
    
    switch goalProgress.reward.trophy {
    case "gold_medal": trophy = "🥇 Gold medal"
    case "silver_medal": trophy = "🥈 Silver medal"
    case "bronze_medal": trophy = "🥉 Bronze medal"
    default: trophy = "-"
    }
    
    return trophy
  }
  
  var points: String {
    guard let goalProgress else { return "-" }
    return "Points: \(goalProgress.reward.points)"
  }
  
  var movement: String {
    guard let myDailyMovement else { return "-" }
    return "Movement: \(myDailyMovement.distance) \(myDailyMovement.type.rawValue)"
  }
  
  public func setViewDelegate(delegate: ProgressPresenterDelegate) {
    self.delegate = delegate
  }
  
  func saveProgress(_ progress: Progress) {
    coreDataManager.saveProgress(progress)
  }
  
  func getDailySteps() {
    let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
    let now = Date()
    let startOfDay = Calendar.current.startOfDay(for: now)
    let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
            
    query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { [weak self] _, result, error in
      guard let self else { return }

      if let error {
        print("\n❌ ERROR: \(error.localizedDescription)")
        self.delegate?.presentAlert(title: "ERROR", message: error.localizedDescription)
      }
      
      guard let result, let sum = result.sumQuantity() else {
        DispatchQueue.main.async {
          self.myDailyMovement = Movement(distance: String(Int(0)), type: .steps)
        }
        
        return
      }
      
      DispatchQueue.main.async {
        self.myDailyMovement = Movement(distance: String(Int(sum.doubleValue(for: HKUnit.count()))), type: .steps)
        guard let goalProgress = self.goalProgress,
              let delegate = self.delegate,
              let myDailyMovement = self.myDailyMovement
        else { return }
        
        let progress = Progress(goalId: goalProgress.id, movement: myDailyMovement)
        delegate.presentProgress(progress)
      }
    }
    
    query.map(healthStore.execute)
  }
  
  func getDistanceWalkingRunning() {
    let distanceQuantityType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
    let now = Date()
    let startOfDay = Calendar.current.startOfDay(for: now)
    let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
            
    query = HKStatisticsQuery(quantityType: distanceQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { [weak self] _, result, error in
      guard let self else { return }

      if let error {
        print("\n❌ ERROR: \(error.localizedDescription)")
        self.delegate?.presentAlert(title: "ERROR", message: error.localizedDescription)
      }
      
      guard let result, let sum = result.sumQuantity() else {
        DispatchQueue.main.async {
          self.myDailyMovement = Movement(distance: String(Int(0)), type: .distanceWalkingRunning)
        }
        
        return
      }
      
      DispatchQueue.main.async {
        let unit = HKUnit.meter()
        let metersDistance = Int(sum.doubleValue(for: unit))
        let kilometersDistance = metersDistance / 1000
        self.myDailyMovement = Movement(distance: String(kilometersDistance), type: .distanceWalkingRunning)
        
        guard let goalProgress = self.goalProgress,
              let delegate = self.delegate,
              let myDailyMovement = self.myDailyMovement
        else { return }
        
        let progress = Progress(goalId: goalProgress.id, movement: myDailyMovement)
        delegate.presentProgress(progress)
      }
    }
    
    query.map(healthStore.execute)
  }
}
