//
//  ProgressPresenter.swift
//  HealthGoals
//
//  Created by Carlos Rodriguez Asensio on 17/2/23.
//

import Foundation

protocol ProgressPresenterProtocol {
  var navigationItemTitle: String { get }
  var title: String { get }
  var description: String { get }
  var goal: String { get }
  var type: String { get }
  var trophy: String { get }
  var points: String { get }
}

final class ProgressPresenter {
  // MARK: Variables
  private let coreDataManager: CoreDataManagerProtocol
  var goalProgress: Goal?
  
  // MARK: Initializer
  init(goal: Goal? = nil, coreDataManager: CoreDataManagerProtocol) {
    goalProgress = goal
    self.coreDataManager = coreDataManager
  }
}

// MARK: - ProgressPresenterProtocol

extension ProgressPresenter: ProgressPresenterProtocol {
  var navigationItemTitle: String { "Progress" }
  
  var title: String {
    guard let goalProgress else { return "-" }
    return goalProgress.title
  }
  
  var description: String {
    guard let goalProgress else { return "-" }
    return goalProgress.description
  }
  
  var goal: String {
    guard let goalProgress else { return "-" }
    return "Goal: \(goalProgress.goal)"
  }
  
  var type: String {
    guard let goalProgress else { return "-" }
    return "Type: \(goalProgress.type)"
  }
  
  var trophy: String {
    guard let goalProgress else { return "-" }
    var trophy: String = ""
    
    switch goalProgress.reward.trophy {
    case "gold_medal": trophy = "🥇 Gold medal"
    case "silver_medal": trophy = "🥈 Silver medal"
    case "bronze_medal": trophy = "🥉 Bronze medal"
    default: trophy = "-"
    }
    
    return trophy
  }
  
  var points: String {
    guard let goalProgress else { return "-" }
    return "Points: \(goalProgress.reward.points)"
  }
}
