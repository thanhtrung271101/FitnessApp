//
//  FitnessTabView.swift
//  FitnessApp
//
//  Created by Thành Trung on 29/12/24.
//

import SwiftUI

struct FitnessTabView: View {
    @AppStorage("userName") var userName: String?
    @State var selectedTab = "Home"
    @State var showTerms = true
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.stackedLayoutAppearance.selected.iconColor = .green
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.green]
        UITabBar.appearance().standardAppearance = appearance
    }
    var body: some View {
        TabView(selection: $selectedTab) {
//            HomeView()
//                .tag("Home")
//                .tabItem {
//                    Image(systemName: "house")
//                    Text("Home")
//                }
            ChartsView()
                .tag("Charts")
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                    Text("Charts")
                }
            LeaderBoardView(showTerms: $showTerms)
                .tag("Leaderboard")
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Leaderboard")
                }
        }
        .onAppear {
            showTerms = userName == nil
        }
        
    }
}

#Preview {
    FitnessTabView()
}
