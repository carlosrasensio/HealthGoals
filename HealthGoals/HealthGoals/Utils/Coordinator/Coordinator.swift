//
//  Coordinator.swift
//  HealthGoals
//
//  Created by Carlos Rodriguez Asensio on 17/2/23.
//

import Foundation
import UIKit

protocol CoordinatorProtocol {
  var navigationController: UINavigationController? { get set }
  
  func start()
  func navigateToProgressView(for goal: Goal)
}

protocol Coordinating {
  var coordinator: Coordinator? { get set }
}

class Coordinator {
  // MARK: Variables
  var navigationController: UINavigationController?
}

// MARK: - CoordinatorProtocol

extension Coordinator: CoordinatorProtocol {
  func start() {
    let presenter = GoalsPresenter(coordinator: self, networkManager: NetworkManager(), coreDataManager: CoreDataManager())
    let view = GoalsViewController(presenter: presenter)
    navigationController?.setViewControllers([view], animated: true)
  }
  
  func navigateToProgressView(for goal: Goal) {
    let presenter = ProgressPresenter(goal: goal, coreDataManager: CoreDataManager())
    let view = ProgressViewController(presenter: presenter)
    navigationController?.pushViewController(view, animated: true)
  }
}
