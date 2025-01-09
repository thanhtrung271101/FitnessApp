//
//  HomeViewModel.swift
//  FitnessApp
//
//  Created by Thành Trung on 8/1/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    let healthManager = HealthManager.shared
    @Published var calories: Int = 0
    @Published var exercise: Int = 0
    @Published var stand: Int = 0
    
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
    
    init() {
        Task {
            do {
                try await healthManager.requestHealthKitAccess()
                fetchTodayCalories()
                fetchTodayExerciseTime()
                fetchTodayStandHours()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func fetchTodayCalories() {
        healthManager.fetchTodayCaloriesBurned { result in
            switch result {
            case .success(let calories):
                DispatchQueue.main.async {
                    self.calories = Int(calories)
                }
            case .failure(let failure):
                print("DEBUG: \(failure.localizedDescription)")
            }
        }
    }
    func fetchTodayExerciseTime() {
        healthManager.fetchTodayExcerciseTime { result in
            switch result {
            case .success(let exercise):
                DispatchQueue.main.async {
                    self.exercise = Int(exercise)
                }
            case .failure(let failure):
                print("DEBUG: \(failure.localizedDescription)")
            }
        }
    }
    func fetchTodayStandHours() {
        healthManager.fetchTodayStandHours { result in
            switch result {
            case .success(let hours):
                DispatchQueue.main.async {
                    self.stand = hours
                }
            case .failure(let failure):
                print("DEBUG: \(failure.localizedDescription)")
            }
        }
    }
}
