//
//  DatabaseManager.swift
//  FitnessApp
//
//  Created by Thành Trung on 24/1/25.
//

import Foundation
import FirebaseFirestore

class DatabaseManager {
    static let shared = DatabaseManager()
    
    private init() {
        
    }
    private let database = Firestore.firestore()
    let weeklyLeaderboards = "\(Date().mondayDateFormat())-leaderboard"
    
    // Fetch Leaderboards
    func fetchLeaderBoards() async throws -> [LeaderboardUser]{
        let snapshot = try await database.collection(weeklyLeaderboards).getDocuments()
        return try snapshot.documents.compactMap({ try $0.data(as: LeaderboardUser.self)})
    }
    // Post (Update) LeaderBoards for current users
    func postStepCountUpdateForUser(leader: LeaderboardUser) async throws {
        let data = try Firestore.Encoder().encode(leader)
        try await database.collection(weeklyLeaderboards).document(leader.userName).setData(data, merge: false)
    }
}
