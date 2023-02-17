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
  
  func setViewDelegate(delegate: GoalsPresenterDelegate)
  func getGoals() async
}

final class GoalsPresenter {
  // MARK: Variables
  private weak var delegate: GoalsPresenterDelegate?
  private let networkManager: NetworkManagerProtocol
    
  // MARK: Initializers
  init(networkManager: NetworkManagerProtocol) {
    self.networkManager = networkManager
  }
}

// MARK: - GoalsPresenterProtocol

extension GoalsPresenter: GoalsPresenterProtocol {
  var title: String { "Goals" }
  
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
}

