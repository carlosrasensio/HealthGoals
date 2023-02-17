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
  func navigateToProgress(for goal: Goal?)
}

final class GoalsCoordinator {
  // MARK: Variables
  private var sourceView: UIViewController?
  var viewController: UIViewController { createGoalsViewController() }
}

// MARK: - CharactersCollectionCoordinatorProtocol

extension GoalsCoordinator: GoalsCoordinatorProtocol {
  func createGoalsViewController() -> UIViewController {
    let presenter = GoalsPresenter(coordinator: GoalsCoordinator(), networkManager: NetworkManager(), coreDataManager: CoreDataManager())
    let view = GoalsViewController(presenter: presenter)

    return view
  }
  
  func setSourceView(_ view: UIViewController?) {
    guard let view else { return }
    sourceView = view
  }
  
  func navigateToProgress(for goal: Goal?) {
    let progressView = ProgressCoordinator(goal: goal).viewController
    sourceView?.navigationController?.pushViewController(progressView, animated: true)
  }
}
