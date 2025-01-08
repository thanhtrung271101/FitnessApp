//
//  HomeView.swift
//  FitnessApp
//
//  Created by Thành Trung on 31/12/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var vm = HomeViewModel()
    
    var body: some View {
        NavigationStack {
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
                                Text("\(vm.calories) kcal")
                                    .font(.subheadline)
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Active")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color(.green))
                                
                                Text("\(vm.active) mins")
                                    .font(.subheadline)
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Standard")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color(.blue))
                                
                                Text("\(vm.standard) hours")
                                    .font(.subheadline)
                            }
                        }
                        Spacer()
                        ZStack {
                            ProgressCircleView(progress: $vm.calories, goal: 600, color: .red)
                            ProgressCircleView(progress: $vm.active, goal: 60, color: .green)
                                .padding(.all, 20)
                            ProgressCircleView(progress: $vm.standard, goal: 12, color: .blue)
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
                        ForEach(vm.mockActivities, id: \.id) { activity in
                            ActivityCards(activity: activity)
                        }
                    }
                    HStack {
                        Text("Recent Workouts")
                            .fontWeight(.bold)
                        Spacer()
                        NavigationLink {
                            EmptyView()
                        } label: {
                            Text("Show more")
                                .padding()
                                .foregroundStyle(Color.white)
                                .background(Color.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    LazyVStack {
                        ForEach(vm.mockWorkout, id: \.id) { workout in
                            WorkoutCard(workout: workout)
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}