//
//  LeaderBoardView.swift
//  FitnessApp
//
//  Created by Thành Trung on 24/1/25.
//

import SwiftUI

struct LeaderboardUser: Codable {
    let id = UUID()
    let userName: String
    let count: Int
}

class LeaderBoardViewModel: ObservableObject {
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
            .task {
                do {
                    try await DatabaseManager.shared.postStepCountUpdateFor(userName: "thanhTrung", count: 7365)
                } catch {
                    print("DEBUG: \(error.localizedDescription)")
                }
            }
            .onAppear {
                print(Date().mondayDateFormat())
            }
        }
    }
}

#Preview {
    LeaderBoardView(showTerms: .constant(false))
}
