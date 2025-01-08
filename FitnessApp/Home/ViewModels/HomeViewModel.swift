//
//  HomeViewModel.swift
//  FitnessApp
//
//  Created by Thành Trung on 8/1/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    var calories: Int = 512
    var active: Int = 12
    var standard: Int = 8
    
    var mockActivities = [
        Activity(id: 0, title: "Today Steps", subtitle: "Goal 10,000", image: "figure.walk", color: .green, amount: "9,123"),
        Activity(id: 1, title: "Today Steps", subtitle: "Goal 10,000", image: "figure.walk", color: .green, amount: "30,423"),
        Activity(id: 2, title: "Today Steps", subtitle: "Goal 10,000", image: "figure.walk", color: .green, amount: "5,653"),
        Activity(id: 3, title: "Today Steps", subtitle: "Goal 10,000", image: "figure.run", color: .green, amount: "123,123")
    ]
    
    var mockWorkout = [
        Workout(id: 0, tintColor: .green, title: "Running", date: "Aug 31", duration: "32 mins", image: "figure.run", calories: "476 Kcal"),
        Workout(id: 1, tintColor: .blue, title: "Badminton", date: "Aug 31", duration: "20 mins", image: "figure.badminton", calories: "476 Kcal"),
        Workout(id: 2, tintColor: .purple, title: "Walking", date: "Aug 31", duration: "50 mins", image: "figure.walk", calories: "476 Kcal"),
        Workout(id: 3, tintColor: .green, title: "Running", date: "Aug 31", duration: "34 mins", image: "figure.run", calories: "476 Kcal"),
        Workout(id: 4, tintColor: .green, title: "Running", date: "Aug 31", duration: "53 mins", image: "figure.run", calories: "476 Kcal")
    ]
}
