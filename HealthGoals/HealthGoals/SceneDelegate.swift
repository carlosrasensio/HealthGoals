//
//  SceneDelegate.swift
//  HealthGoals
//
//  Created by Carlos Rodriguez Asensio on 17/2/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  var coreDataManager: CoreDataManager?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    /// App main view configuration
    let navigationController = UINavigationController()
    let coordinator = Coordinator()
    coordinator.navigationController = navigationController
    configureNavigationBar(navigationController)
    let window = UIWindow(windowScene: windowScene)
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
    self.window = window
    coordinator.start()
  }
  
  func sceneDidEnterBackground(_ scene: UIScene) {
    coreDataManager = CoreDataManager()
    coreDataManager!.saveContext()
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

