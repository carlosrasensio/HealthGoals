//
//  ProgressPresenterTests.swift
//  HealthGoalsTests
//
//  Created by Carlos Rodriguez Asensio on 22/2/23.
//

import XCTest
@testable import HealthGoals

final class ProgressPresenterTests: XCTestCase {
  var sut: ProgressPresenterProtocol?
  private let jsonName = "MockGoals"
  private let jsonExtension = ".json"
  private var mockGoal: Goal?
  
  override func setUpWithError() throws {
    let bundle = Bundle(for: TestBundleClass.self)
    let goalsResponse = bundle.decode(GoalsResponse.self, from: jsonName + jsonExtension)
    mockGoal = goalsResponse.goals.first
    sut = ProgressPresenter(goal: mockGoal!, coreDataManager: CoreDataManager())
    try super.setUpWithError()
  }
  
  override func tearDownWithError() throws {
    sut = nil
    mockGoal = nil
    try super.tearDownWithError()
  }
  
  func testGoalProgressTitle() {
    XCTAssertTrue(sut?.title == mockGoal?.title)
  }
  
  func testGoalProgressDescription() {
    XCTAssertTrue(sut?.description == mockGoal?.description)
  }
  
  func testGoalProgressGoal() {
    let characters = mockGoal?.goal
    XCTAssertTrue(sut!.goal.contains(characters!))
  }
  
  func testGoalProgressType() {
    let characters = mockGoal?.type.rawValue
    XCTAssertTrue(sut!.type.contains(characters!))
  }
  
  func testGoalProgressPoints() {
    let characters = mockGoal?.reward.points
    XCTAssertTrue(sut!.points.contains(characters!))
  }
}
