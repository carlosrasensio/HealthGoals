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
  let goal, description, title, type: String
  let reward: Reward
}

// MARK: - Reward
struct Reward: Codable {
  let trophy, points: String
}
