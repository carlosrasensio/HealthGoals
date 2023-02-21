//
//  Goal.swift
//  HealthGoals
//
//  Created by Carlos Rodriguez Asensio on 17/2/23.
//

import Foundation

// MARK: - GoalsResponse
struct GoalsResponse: Codable {
  let goals: [Goal]
}

// MARK: - Goal
struct Goal: Codable {
  let id: Int
  let goal, description, title: String
  let type: GoalType
  let reward: Reward
  
  enum CodingKeys: String, CodingKey {
    case id, goal, description, title, type, reward
  }
}

enum GoalType: String, Codable {
  case step = "step"
  case walking = "walking_distance"
  case running = "running_distance"
}

// MARK: - Reward
struct Reward: Codable {
  let trophy: Trophy
  let points: String
}

enum Trophy: String, Codable {
  case goldMedal = "gold_medal"
  case silverMedal = "silver_medal"
  case bronzeMedal = "bronze_medal"
  case zombieHand = "zombie_hand"
}
