//
//  LeaderBoardView.swift
//  FitnessApp
//
//  Created by Thành Trung on 24/1/25.
//

import SwiftUI

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
                LazyVStack(spacing: 20) {
                    ForEach(viewModel.leaders, id: \.id) { user in
                        Divider()
                        HStack {
                            Text("1.")
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
