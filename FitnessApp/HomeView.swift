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

    var body: some View {
        ScrollView(showsIndicators: false) {
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
        }
    }
}

#Preview {
    HomeView()
}
