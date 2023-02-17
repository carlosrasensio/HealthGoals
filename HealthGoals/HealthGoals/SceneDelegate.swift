//
//  SceneDelegate.swift
//  HealthGoals
//
//  Created by Carlos Rodriguez Asensio on 17/2/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    // MARK: App main view configuration
    window = UIWindow(frame: UIScreen.main.bounds)
    let viewController = GoalsCoordinator().viewController
    let navigationController = UINavigationController(rootViewController: viewController)
    configureNavigationBar(navigationController)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
    window?.windowScene = windowScene

  }
  
  func sceneDidEnterBackground(_ scene: UIScene) {
    /// This way, Core Data will save the data each time the user leaves the app in the background
    (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
  }
}

// MARK: - Navigation bar configuration

private extension SceneDelegate {
  func configureNavigationBar(_ navigationController: UINavigationController) {
    let appearance = UINavigationBarAppearance()
    appearance.backgroundColor = .systemCyan
    appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    navigationController.navigationBar.tintColor = .white
    navigationController.navigationBar.standardAppearance = appearance
    navigationController.navigationBar.compactAppearance = appearance
    navigationController.navigationBar.scrollEdgeAppearance = appearance
  }
}

