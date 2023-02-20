//
//  AppDelegate.swift
//  HealthGoals
//
//  Created by Carlos Rodriguez Asensio on 17/2/23.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  static let sharedAppDelegate: AppDelegate = {
    guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
      fatalError("❌ ERROR: unexpected app delegate type, did it change? \(String(describing: UIApplication.shared.delegate))")
    }
    
    return delegate
  }()
  
  // MARK: Core Data stack
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "HealthGoals")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("\n❌ Unresolved error \(error), \(error.userInfo)")
      }
    })
    
    return container
  }()
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let navigationController = UINavigationController()
    let coordinator = Coordinator()
    coordinator.navigationController = navigationController
    configureNavigationBar(navigationController)
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
    self.window = window
    coordinator.start()
    
    return true
  }
  
  // MARK: UISceneSession Lifecycle
  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }
}

// MARK: - Navigation bar configuration

private extension AppDelegate {
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

// MARK: - Core Data

extension AppDelegate {
  /// Core Data Saving support
  func saveContext() {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("\n❌ Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
}

