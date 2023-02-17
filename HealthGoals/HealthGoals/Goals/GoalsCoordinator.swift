//
//  GoalsCoordinator.swift
//  HealthGoals
//
//  Created by Carlos Rodriguez Asensio on 17/2/23.
//

import Foundation
import UIKit

protocol GoalsCoordinatorProtocol: AnyObject {
  func createGoalsViewController() -> UIViewController
  func setSourceView(_ view: UIViewController?)
}

final class GoalsCoordinator {
  // MARK: Variables
  private var sourceView: UIViewController?
  var viewController: UIViewController { createGoalsViewController() }
}

// MARK: - CharactersCollectionCoordinatorProtocol

extension GoalsCoordinator: GoalsCoordinatorProtocol {
  func createGoalsViewController() -> UIViewController {
    let view = GoalsViewController(coordinator: GoalsCoordinator())

    return view
  }
  
  func setSourceView(_ view: UIViewController?) {
    guard let view else { return }
    sourceView = view
  }
}