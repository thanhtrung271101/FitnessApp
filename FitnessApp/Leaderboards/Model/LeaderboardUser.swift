//
//  LeaderboardUser.swift
//  FitnessApp
//
//  Created by Thành Trung on 6/2/25.
//

import Foundation

struct LeaderboardUser: Codable, Identifiable {
    let id = UUID()
    let userName: String
    let count: Int
}
