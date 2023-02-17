//
//  GoalsPresenter.swift
//  HealthGoals
//
//  Created by Carlos Rodriguez Asensio on 17/2/23.
//

import Foundation

protocol GoalsPresenterDelegate: AnyObject {
  func presentGoals(_ goals: [Goal])
  func presentAlert(title: String, message: String)
}

protocol GoalsPresenterProtocol {
  var navigationItemTitle: String { get }
  
  func setViewDelegate(delegate: GoalsPresenterDelegate)
  func getGoals() async
  func didSelectGoal(_ goal: Goal)
}

final class GoalsPresenter {
  // MARK: Variables
  private weak var delegate: GoalsPresenterDelegate?
  private let coordinator: GoalsCoordinatorProtocol
  private let networkManager: NetworkManagerProtocol
  private let coreDataManager: CoreDataManagerProtocol
    
  // MARK: Initializers
  init(coordinator: GoalsCoordinatorProtocol, networkManager: NetworkManagerProtocol, coreDataManager: CoreDataManagerProtocol) {
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
    do {
      let goals = try await networkManager.getGoals()
      delegate?.presentGoals(goals)
    } catch {
      print("\n❌ ERROR: \(error.localizedDescription)")
      delegate?.presentAlert(title: "ERROR", message: error.localizedDescription)
    }
  }
  
  func didSelectGoal(_ goal: Goal) {
    coordinator.navigateToProgress(for: goal)
  }
}

