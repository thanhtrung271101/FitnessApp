//
//  LeaderBoardView.swift
//  FitnessApp
//
//  Created by Thành Trung on 24/1/25.
//

import SwiftUI

struct LeaderBoardView: View {
    @AppStorage("userName") var userName: String?
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
                LazyVStack() {
                    ForEach(Array(viewModel.leadersResult.top10.enumerated()), id: \.element.id) { (idx, person) in
                        Divider()
                        HStack {
                            Text("\(idx + 1).")
                            Text(person.userName)
                            if userName == person.userName {
                                Image(systemName: "crown.fill")
                                    .foregroundStyle(.yellow)
                            }
                            Spacer()
                            Text("\(person.count)")
                        }
                        .padding(.horizontal)
                    }
                }
                if let user = viewModel.leadersResult.user {
                    HStack {
                        Text(user.userName)
                        Spacer()
                        Text("\(user.count)")
                    }
                    .padding(.horizontal)
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
