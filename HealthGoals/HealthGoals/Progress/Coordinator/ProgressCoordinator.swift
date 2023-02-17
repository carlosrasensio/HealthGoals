//
//  ProgressCoordinator.swift
//  HealthGoals
//
//  Created by Carlos Rodriguez Asensio on 17/2/23.
//

import Foundation
import UIKit

protocol ProgressCoordinatorProtocol {
  func createProgressViewController() -> UIViewController
}

final class ProgressCoordinator {
  // MARK: Variables
  private var sourceView: UIViewController?
  var viewController: UIViewController {
    createProgressViewController()
  }
  private var goal: Goal?
  
  // MARK: Initializer
  init(goal: Goal? = nil) {
    self.goal = goal
  }
}

// MARK: - ProgressCoordinatorProtocol

extension ProgressCoordinator: ProgressCoordinatorProtocol {
  func createProgressViewController() -> UIViewController {
    let presenter = ProgressPresenter(goal: goal)
    let view = ProgressViewController(presenter: presenter, coordinator: ProgressCoordinator())
    
    return view
  }
}
