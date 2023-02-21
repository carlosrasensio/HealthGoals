//
//  GoalsPresenter.swift
//  HealthGoals
//
//  Created by Carlos Rodriguez Asensio on 17/2/23.
//

import Foundation
import HealthKit

protocol GoalsPresenterDelegate: AnyObject {
  func presentGoals(_ goals: [Goal])
  func presentAlert(title: String, message: String)
}

protocol GoalsPresenterProtocol {
  var navigationItemTitle: String { get }
  
  func setViewDelegate(delegate: GoalsPresenterDelegate)
  func getGoals() async
  func saveGoals(_ goals: [Goal])
  func didSelectGoal(_ goal: Goal)
  func requestAccessToHealthData()
}

final class GoalsPresenter {
  // MARK: Variables
  private weak var delegate: GoalsPresenterDelegate?
  private let networkManager: NetworkManagerProtocol
  private let coreDataManager: CoreDataManagerProtocol
  var coordinator: Coordinator?
  private let healthStore = HKHealthStore()
    
  // MARK: Initializers
  init(coordinator: Coordinator, networkManager: NetworkManagerProtocol, coreDataManager: CoreDataManagerProtocol) {
    self.coordinator = coordinator
    self.networkManager = networkManager
    self.coreDataManager = coreDataManager
  }
}

// MARK: - GoalsPresenterProtocol

extension GoalsPresenter: GoalsPresenterProtocol {
  var navigationItemTitle: String { "Goals" }
  
  public func setViewDelegate(delegate: GoalsPresenterDelegate) {
    self.delegate = delegate
  }
  
  func getGoals() async {
    var goals = [Goal]()
    do {
      goals = try await networkManager.getGoals()
    } catch {
      print("\n❌ ERROR: \(error.localizedDescription)")
      delegate?.presentAlert(title: "ERROR", message: error.localizedDescription)
      goals = coreDataManager.getCoreDataGoals()
    }
    
    delegate?.presentGoals(goals)
  }
  
  func saveGoals(_ goals: [Goal]) {
    goals.forEach {
      coreDataManager.saveGoal($0)
    }
  }
  
  func didSelectGoal(_ goal: Goal) {
    coordinator?.navigateToProgressView(for: goal)
  }
  
  func requestAccessToHealthData() {
    let readableTypes: Set<HKSampleType> = [HKQuantityType.quantityType(forIdentifier: .stepCount)!, HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!]
    guard HKHealthStore.isHealthDataAvailable() else { return }
    healthStore.requestAuthorization(toShare: nil, read: readableTypes) { [weak self] success, error in
      guard let self else { return }
      
      if let error {
        self.delegate?.presentAlert(title: "ERROR", message: error.localizedDescription)
      }
      
      if success {
        print("\nℹ️ Request authorization: \(success.description)")
      }
    }
  }
}

// MARK: - Coordinating

extension GoalsPresenter: Coordinating {}

