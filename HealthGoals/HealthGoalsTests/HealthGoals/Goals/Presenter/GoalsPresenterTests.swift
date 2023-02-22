//
//  GoalsPresenterTests.swift
//  HealthGoalsTests
//
//  Created by Carlos Rodriguez Asensio on 22/2/23.
//

import XCTest
@testable import HealthGoals

final class GoalsPresenterTests: XCTestCase {
  var sut: GoalsPresenterProtocol?
  
  override func setUpWithError() throws {
    sut = GoalsPresenter(coordinator: Coordinator(), networkManager: NetworkManager(), coreDataManager: CoreDataManager())
    try super.setUpWithError()
  }
  
  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }
}
