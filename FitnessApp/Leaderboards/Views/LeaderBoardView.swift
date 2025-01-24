//
//  LeaderBoardView.swift
//  FitnessApp
//
//  Created by Thành Trung on 24/1/25.
//

import SwiftUI

struct LeaderboardUser: Codable {
    let id: Int
    let createAt: String
    let userName: String
    let count: Int
}

class LeaderBoardViewModel: ObservableObject {
    let mockData = [
        LeaderboardUser(id: 1, createAt: "2025-01-10", userName: "Alice", count: 3456),
        LeaderboardUser(id: 2, createAt: "2025-01-12", userName: "Bob", count: 4521),
        LeaderboardUser(id: 3, createAt: "2025-01-15", userName: "Charlie", count: 3890),
        LeaderboardUser(id: 4, createAt: "2025-01-18", userName: "Diana", count: 4102),
        LeaderboardUser(id: 5, createAt: "2025-01-20", userName: "Ethan", count: 2987),
        LeaderboardUser(id: 6, createAt: "2025-01-22", userName: "Fiona", count: 5203),
        LeaderboardUser(id: 7, createAt: "2025-01-23", userName: "George", count: 3712),
        LeaderboardUser(id: 8, createAt: "2025-01-24", userName: "Hannah", count: 4021),
        LeaderboardUser(id: 9, createAt: "2025-01-25", userName: "Ian", count: 4455),
        LeaderboardUser(id: 10, createAt: "2025-01-25", userName: "Jane", count: 3789)
    ]

}

struct LeaderBoardView: View {
    @StateObject var viewModel = LeaderBoardViewModel()
    @Binding var showTerms: Bool
    var body: some View {
        ScrollView {
            VStack {
                Text("Leaderboard")
                    .font(.largeTitle)
                    .bold()
                HStack {
                    Text("Name")
                        .bold()
                    
                    Spacer()
                    
                    Text("Steps")
                        .bold()
                }
                .padding()
                LazyVStack {
                    ForEach(viewModel.mockData, id: \.id) { user in
                        Divider()
                        HStack {
                            Text("\(user.id).")
                            Text(user.userName)
                            Spacer()
                            Text("\(user.count)")
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .fullScreenCover(isPresented: $showTerms) {
                TermsView()
            }
        }
    }
}

#Preview {
    LeaderBoardView(showTerms: .constant(false))
}
