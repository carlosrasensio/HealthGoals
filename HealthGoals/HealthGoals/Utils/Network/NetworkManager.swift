//
//  NetworkManager.swift
//  HealthGoals
//
//  Created by Carlos Rodriguez Asensio on 17/2/23.
//

import Foundation

protocol NetworkManagerProtocol: AnyObject {
  func getGoals() async throws -> [Goal]
}

final class NetworkManager {}

// MARK: - NetworkManagerProtocol

extension NetworkManager: NetworkManagerProtocol {
  func getGoals() async throws -> [Goal] {
    var goals = [Goal]()
    let urlString = "https://d9fd1bed-3c81-43a5-bb37-bc97488093f7.mock.pstmn.io/goals"
    guard let url = URL(string: urlString) else {
      print("\n❌ ERROR: URL not valid\n")
      return goals
    }
    
    let urlRequest = URLRequest(url: url)
    let (data, _) = try await URLSession.shared.data(for: urlRequest)
    
    do {
      let response = try JSONDecoder().decode(GoalsResponse.self, from: data)
      goals = response.goals
      print(goals)
    } catch {
      print("\n❌ ERROR: \(error.localizedDescription)\n")
    }
    
    return goals
  }
}
