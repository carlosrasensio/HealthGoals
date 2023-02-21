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
  func deleteProgressWith(id: Int)
  func getCoreDataProgress() -> [Progress]
}

final class CoreDataManager {
  // MARK: Variables
  private let coreDataModel = "HealthGoals"
  private let healthGoalEntity = "HealthGoal"
  private let goalProgressEntity = "GoalProgress"
  
  // MARK: Core Data stack
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: coreDataModel)
    container.loadPersistentStores(completionHandler: { _, error in
      if let error = error as NSError? {
        fatalError("\n❌ Unresolved error \(error), \(error.userInfo)")
      }
    })
    
    return container
  }()
  
  var context: NSManagedObjectContext {
      persistentContainer.viewContext
  }
  
  // MARK: Core Data Saving support
  func saveContext() {
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

// MARK:  - DataManagerProtocol

extension CoreDataManager: CoreDataManagerProtocol {
  func saveGoal(_ goal: Goal) {
    let fetchRequest: NSFetchRequest<HealthGoal> = HealthGoal.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "id == %@", String(goal.id))
    
    do {
      let goals = try context.fetch(fetchRequest)
      let filteredGoals = goals.filter { String(goal.id) == $0.id }
      
      if filteredGoals.isEmpty {
        let goalEntity = NSEntityDescription.entity(forEntityName: healthGoalEntity, in: context)!
        let healthGoal = NSManagedObject(entity: goalEntity, insertInto: context)
        
        healthGoal.setValuesForKeys(["id": String(goal.id), "title": goal.title, "desc": goal.description, "goal": goal.goal, "type": goal.type.rawValue, "trophy": goal.reward.trophy.rawValue, "points": goal.reward.points])
        
        try context.save()
      }
    } catch {
      fatalError("\n❌ ERROR: failed to save goal --> \(error.localizedDescription)")
    }
  }
  
  func deleteGoalWith(id: Int) {
    let fetchRequest: NSFetchRequest<HealthGoal> = HealthGoal.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "id == %@", String(id))

    guard let goal = try? context.fetch(fetchRequest).first else {
        print("\nℹ️ Goal with ID \(id) not found")
        return
    }

    context.delete(goal)

    do {
        try context.save()
    } catch {
        print("\n❌ Error saving context: \(error)")
    }
  }
  
  func getCoreDataGoals() -> [Goal] {
    do {
      let fetchRequest: NSFetchRequest<HealthGoal> = HealthGoal.fetchRequest()
      let healthGoals = try context.fetch(fetchRequest)
      let goals = healthGoals.map {
        Goal(id: Int($0.id!)!, goal: $0.goal!, description: $0.desc!, title: $0.title!, type: GoalType(rawValue: $0.type!)!, reward: Reward(trophy: Trophy(rawValue: $0.trophy!)!, points: $0.points!))
      }
      
      return goals
    } catch {
      fatalError("\n❌ ERROR: failed to get goals --> \(error.localizedDescription)")
    }
  }
  
  func saveProgress(_ progress: Progress) {
    let fetchRequest: NSFetchRequest<GoalProgress> = GoalProgress.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "id == %@", String(progress.goalId))
    
    do {
      let fetchedProgress = try context.fetch(fetchRequest)
      let filteredProgress = fetchedProgress.filter { String(progress.goalId) == $0.id}
      
      if filteredProgress.isEmpty {
        let progressEntity = NSEntityDescription.entity(forEntityName: goalProgressEntity, in: context)!
        let goalProgress = NSManagedObject(entity: progressEntity, insertInto: context)
        
        goalProgress.setValuesForKeys(["id": String(progress.goalId), "distance": progress.movement.distance, "movementType": progress.movement.type.rawValue])
        
        try context.save()
      }
    } catch {
      fatalError("\n❌ ERROR: failed to save progress --> \(error.localizedDescription)")
    }
  }
  
  func deleteProgressWith(id: Int) {
    let fetchRequest: NSFetchRequest<GoalProgress> = GoalProgress.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "id == %@", String(id))

    guard let progress = try? context.fetch(fetchRequest).first else {
        print("\nℹ️ Progress with ID \(id) not found")
        return
    }

    context.delete(progress)

    do {
        try context.save()
    } catch {
        print("\n❌ Error saving context: \(error)")
    }
  }
  
  func getCoreDataProgress() -> [Progress] {
    do {
      let fetchRequest: NSFetchRequest<GoalProgress> = GoalProgress.fetchRequest()
      let goalProgress = try context.fetch(fetchRequest)
      let progress = goalProgress.map {
        Progress(goalId: Int($0.id!)!, movement: Movement(distance: $0.distance!, type: MovementType(rawValue: $0.movementType!)!))
      }
      
      return progress
    } catch {
      fatalError("\n❌ ERROR: failed to get progress --> \(error.localizedDescription)")
    }
  }
}
