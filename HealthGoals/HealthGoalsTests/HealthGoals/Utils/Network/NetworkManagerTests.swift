//
//  NetworkManagerTests.swift
//  HealthGoalsTests
//
//  Created by Carlos Rodriguez Asensio on 22/2/23.
//

import XCTest
@testable import HealthGoals

final class NetworkManagerTests: XCTestCase {
  // MARK: Variables
  var sut: NetworkManagerProtocol?
  private let jsonName = "MockGoals"
  private let jsonExtension = ".json"
  var goals: [Goal]?
  var mockGoals: [Goal]?
  
  // MARK: Configuration
  override func setUpWithError() throws {
    sut = NetworkManager()
    guard let sut else { return }
    
    Task {
      goals = try await sut.getGoals()
    }
    
    let bundle = Bundle(for: TestBundleClass.self)
    let goalsResponse = bundle.decode(GoalsResponse.self, from: jsonName + jsonExtension)
    mockGoals = goalsResponse.goals
    
    try super.setUpWithError()
  }
  
  override func tearDownWithError() throws {
    sut = nil
    goals = nil
    mockGoals = nil
    try super.tearDownWithError()
  }
  
  // MARK: - Tests
  
  func testGoalsCount() {
    guard let goals else { return }
    XCTAssertEqual(goals.count, mockGoals?.count)
  }
  
  func testGoalsTitles() {
    guard let goals, let mockGoals else { return }
    for index in goals.indices {
      XCTAssertEqual(goals[index].title, mockGoals[index].title)
    }
  }
  
  func testGoalsDescriptions() {
    guard let goals, let mockGoals else { return }
    for index in goals.indices {
      XCTAssertEqual(goals[index].description, mockGoals[index].description)
    }
  }

  func testGoalsGoals() {
    guard let goals, let mockGoals else { return }
    for index in goals.indices {
      XCTAssertEqual(goals[index].goal, mockGoals[index].goal)
    }
  }

  func testGoalsTypes() {
    guard let goals, let mockGoals else { return }
    for index in goals.indices {
      XCTAssertEqual(goals[index].type, mockGoals[index].type)
    }
  }
  
  func testGoalsTrophies() {
    guard let goals, let mockGoals else { return }
    for index in goals.indices {
      XCTAssertEqual(goals[index].reward.trophy, mockGoals[index].reward.trophy)
    }
  }

  func testGoalsPoints() {
    guard let goals, let mockGoals else { return }
    for index in goals.indices {
      XCTAssertEqual(goals[index].reward.points, mockGoals[index].reward.points)
    }
  }
}
