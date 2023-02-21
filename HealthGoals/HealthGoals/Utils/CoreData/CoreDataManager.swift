//
//  CoreDataManager.swift
//  HealthGoals
//
//  Created by Carlos Rodriguez Asensio on 17/2/23.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
  func saveGoal(_ goal: Goal)
  func deleteGoalWith(id: Int)
  func getCoreDataGoals() -> [Goal]
  func saveProgress(_ progress: Progress)
}

final class CoreDataManager {
  // MARK: Variables
  private let healthGoalEntity = "HealthGoal"
  private let goalProgressEntity = "GoalProgress"

  private lazy var goalPersistentContainer: NSPersistentContainer = {
    let persistentContainer = NSPersistentContainer(name: healthGoalEntity)
    persistentContainer.loadPersistentStores { _, error in
      if let error = error as NSError? {
        print("\n❌ ERROR: \(error.localizedDescription), \(error.userInfo)")
      }
    }
    
    return persistentContainer
  }()
  
  var goalContext: NSManagedObjectContext {
      goalPersistentContainer.viewContext
  }
  
  private lazy var progressPersistentContainer: NSPersistentContainer = {
    let persistentContainer = NSPersistentContainer(name: goalProgressEntity)
    persistentContainer.loadPersistentStores { _, error in
      if let error = error as NSError? {
        print("\n❌ ERROR: \(error.localizedDescription), \(error.userInfo)")
      }
    }
    
    return persistentContainer
  }()
  
  var progressContext: NSManagedObjectContext {
    progressPersistentContainer.viewContext
  }
}

// MARK:  - DataManagerProtocol

extension CoreDataManager: CoreDataManagerProtocol {
  func saveGoal(_ goal: Goal) {
//    let healthGoal = HealthGoal(context: goalContext)
//    healthGoal.setValuesForKeys(["id": goal.id, "title": goal.title, "descr": goal.description, "goal": goal.goal, "type": goal.type, "rewardTrophy": goal.reward.trophy, "rewardPoints": goal.reward.points])
//    do {
//      try goalContext.save()
//    } catch {
//      fatalError("\n❌ ERROR: failed to save goal --> \(error.localizedDescription)")
//    }
  }
  
  func deleteGoalWith(id: Int) {
    let fetchRequest = NSFetchRequest<HealthGoal>(entityName: healthGoalEntity)
    fetchRequest.predicate = NSPredicate(format:"id = %@", id)
    do {
      let goals = try goalContext.fetch(fetchRequest)
      if goals.count > 0 {
        goalContext.delete(goals[0])
      }
      try goalContext.save()
    } catch {
      fatalError("\n❌ ERROR: failed to delete goal --> \(error.localizedDescription)")
    }
  }
  
  func getCoreDataGoals() -> [Goal] {
    let fetchRequest = NSFetchRequest<HealthGoal>(entityName: healthGoalEntity)
    var goals = [Goal]()
    do {
      let healthGoals = try goalContext.fetch(fetchRequest)
      goals = healthGoals.map {
        Goal(id: Int($0.id), goal: $0.goal!, description: $0.descr!, title: $0.title!, type: $0.type!, reward: Reward(trophy: $0.rewardTrophy!, points: $0.rewardPoints!))
      }
    } catch let error as NSError {
      print("\n❌ ERROR: failed to get goals --> \(error.localizedDescription), \(error.userInfo)")
    }
    
    return goals
  }
  
    func saveProgress(_ progress: Progress) {
  //    let goalProgress = HealthProgress(context: progressContext)
  //    goalProgress.setValuesForKeys(["id": progress.goalId, "steps": progress.steps])
  //    do {
  //      try progressContext.save()
  //    } catch {
  //      fatalError("\n❌ ERROR: failed to save goal progress --> \(error.localizedDescription)")
  //    }
    }
}
