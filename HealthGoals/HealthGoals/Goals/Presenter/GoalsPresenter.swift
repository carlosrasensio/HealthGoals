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
  var title: String { get }
  
  func getGoals() async
}

final class GoalsPresenter {
  // MARK: Variables
  private weak var delegate: GoalsPresenterDelegate?
  private let networkManager: NetworkManager
    
  // MARK: Initializers
  init(networkManager: NetworkManager) {
    self.networkManager = networkManager
  }
}

// MARK: - Delegate configuration

extension GoalsPresenter {
  public func setViewDelegate(delegate: GoalsPresenterDelegate) {
    self.delegate = delegate
  }
}

// MARK: - GoalsPresenterProtocol

extension GoalsPresenter: GoalsPresenterProtocol {
  var title: String { "Goals" }
  
  func getGoals() async {
    do {
      let goals = try await networkManager.getGoals()
      delegate?.presentGoals(goals)
    } catch {
      print("\n❌ ERROR: \(error.localizedDescription)")
      delegate?.presentAlert(title: "ERROR", message: error.localizedDescription)
    }
  }
}

