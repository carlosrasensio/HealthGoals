//
//  ProgressPresenter.swift
//  HealthGoals
//
//  Created by Carlos Rodriguez Asensio on 17/2/23.
//

import Foundation
import HealthKit

protocol ProgressPresenterProtocol {
  var navigationItemTitle: String { get }
  var title: String { get }
  var description: String { get }
  var goal: String { get }
  var type: String { get }
  var trophy: String { get }
  var points: String { get }
  var steps: String { get }
  
  func saveProgress(_ progress: Progress)
  func getTodaySteps()
}

final class ProgressPresenter {
  // MARK: Variables
  private let coreDataManager: CoreDataManagerProtocol
  private var goalProgress: Goal?
  private let healthStore = HKHealthStore()
  private var observerQuery: HKObserverQuery?
  private var mySteps = "0"
  private var query: HKStatisticsQuery?
  
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
  
  var steps: String {
    return "Steps: \(mySteps)"
  }
  
  func getTodaySteps() {
    guard let stepCountType = HKObjectType.quantityType(forIdentifier: .stepCount) else {
      print("\n❌ ERROR: identifier .stepCount")
      return
    }
    
    observerQuery = HKObserverQuery(sampleType: stepCountType, predicate: nil, updateHandler: { [weak self] _, _, error in
      guard let self else { return }
      
      if let error {
        print("\n❌ ERROR: \(error.localizedDescription)")
      }
      
      self.getMySteps()
    })
    
    observerQuery.map(healthStore.execute)
  func saveProgress(_ progress: Progress) {
    coreDataManager.saveProgress(progress)
  }
}

// MARK: - Private methods

private extension ProgressPresenter {
  func getMySteps() {
    let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
    let now = Date()
    let startOfDay = Calendar.current.startOfDay(for: now)
    let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
    query = HKStatisticsQuery(
      quantityType: stepsQuantityType,
      quantitySamplePredicate: predicate,
      options: .cumulativeSum,
      completionHandler: { _, result, error in
      if let error {
        print("\n❌ ERROR: \(error.localizedDescription)")
      }
      
      guard let result, let sum = result.sumQuantity() else {
        DispatchQueue.main.async {
          self.mySteps = String(Int(0))
        }
        
        return
      }
      
      DispatchQueue.main.async {
        self.mySteps = String(Int(sum.doubleValue(for: HKUnit.count())))
      }
    })
    
    query.map(healthStore.execute)
  }
}
