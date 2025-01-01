//
//  HomeView.swift
//  FitnessApp
//
//  Created by Thành Trung on 31/12/24.
//

import SwiftUI

struct HomeView: View {
    @State var calories: Int = 512
    @State var active: Int = 12
    @State var standard: Int = 8
    
    var mockActivities = [
        Activity(id: 0, title: "Today Steps", subtitle: "Goal 10,000", image: "figure.walk", color: .green, amount: "9,123"),
        Activity(id: 1, title: "Today Steps", subtitle: "Goal 10,000", image: "figure.walk", color: .green, amount: "30,423"),
        Activity(id: 2, title: "Today Steps", subtitle: "Goal 10,000", image: "figure.walk", color: .green, amount: "5,653"),
        Activity(id: 3, title: "Today Steps", subtitle: "Goal 10,000", image: "figure.run", color: .green, amount: "123,123")
    ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                Text("Welcome to Fitness App")
                    .font(.largeTitle)
                    .padding()
                
                HStack {
                    Spacer()
                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Calories")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundStyle(Color(.red))
                            Text("\(calories) kcal")
                                .font(.subheadline)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Active")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundStyle(Color(.green))
                            
                            Text("\(active) mins")
                                .font(.subheadline)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Standard")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundStyle(Color(.blue))
                            
                            Text("\(standard) hours")
                                .font(.subheadline)
                        }
                    }
                    Spacer()
                    ZStack {
                        ProgressCircleView(progress: $calories, goal: 600, color: .red)
                        ProgressCircleView(progress: $active, goal: 60, color: .green)
                            .padding(.all, 20)
                        ProgressCircleView(progress: $standard, goal: 12, color: .blue)
                            .padding(.all, 40)
                    }
                    .padding(.horizontal)
                    Spacer()
                }
                .padding()
                HStack {
                    Text("Fitness Activities")
                        .fontWeight(.bold)
                    Spacer()
                    Button("Show more") {
                        print("Show more")
                    }
                    .padding()
                    .foregroundStyle(Color.white)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                }
                .padding(.horizontal)
                LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2)) {
                    ForEach(mockActivities, id: \.id) { activity in
                        ActivityCards(activity: activity)
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
