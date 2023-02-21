//
//  Progress.swift
//  HealthGoals
//
//  Created by Carlos Rodriguez Asensio on 21/2/23.
//

import Foundation

// MARK: - Progress
struct Progress {
  let goalId: Int
  let movement: Movement
}

// MARK: - Movement
struct Movement {
  let distance: String
  let type: MovementType
  
  enum MovementType: String {
    case steps = "steps"
    case distanceWalkingRunning = "km"
  }
}

