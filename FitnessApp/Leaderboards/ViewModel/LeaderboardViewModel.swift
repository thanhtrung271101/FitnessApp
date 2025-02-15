//
//  LeaderboardViewModel.swift
//  FitnessApp
//
//  Created by Thành Trung on 6/2/25.
//

import Foundation

class LeaderBoardViewModel: ObservableObject {
    @Published var leadersResult = LeaderboardResult(user: nil, top10: [])
    let mockData = [
        LeaderboardUser(userName: "Alice", count: 3456),
        LeaderboardUser(userName: "Bob", count: 4521),
        LeaderboardUser(userName: "Charlie", count: 3890),
        LeaderboardUser(userName: "Diana", count: 4102),
        LeaderboardUser(userName: "Ethan", count: 2987),
        LeaderboardUser(userName: "Fiona", count: 5203),
        LeaderboardUser(userName: "George", count: 3712),
        LeaderboardUser(userName: "Hannah", count: 4021),
        LeaderboardUser(userName: "Ian", count: 4455),
        LeaderboardUser(userName: "Jane", count: 3789)
    ]

    init() {
        Task {
            do {
                try await setupLeaderboardData()
            } catch {
                print("DEBUG: \(error.localizedDescription)")
            }
        }
    }
    func setupLeaderboardData() async throws {
        try await postStepCountForUser()
        let result = try await fetchLeaderboards()
        DispatchQueue.main.async {
            self.leadersResult = result
        }
    }
    struct LeaderboardResult {
        let user: LeaderboardUser?
        let top10: [LeaderboardUser]
    }
    private func fetchLeaderboards() async throws -> LeaderboardResult{
        let leaders = try await DatabaseManager.shared.fetchLeaderBoards()
        let top10 = Array(leaders.sorted(by: {$0.count > $1.count}).prefix(10))
        let userName = UserDefaults.standard.string(forKey: "userName")
        
        if let userName = userName, !top10.contains(where: { $0.userName == userName }) {
            let user = leaders.first(where: {$0.userName == userName})
            return LeaderboardResult(user: user, top10: top10)
        } else {
            return LeaderboardResult(user: nil, top10: top10)
        }
    }
    
    private func postStepCountForUser() async throws {
        guard let userName = UserDefaults.standard.string(forKey: "userName") else {
            throw URLError(.badURL)
        }
        let steps = try await fetchCurrentWeekStepCount()
        try await DatabaseManager.shared.postStepCountUpdateForUser(leader: LeaderboardUser(userName: userName, count: Int(steps)))
    }
    
    private func fetchCurrentWeekStepCount() async throws -> Double {
        try await withCheckedThrowingContinuation({ continuation in
            HealthManager.shared.fetchCurrentWeekStepCount { result in
                continuation.resume(with: result)
            }
        })
    }
}
