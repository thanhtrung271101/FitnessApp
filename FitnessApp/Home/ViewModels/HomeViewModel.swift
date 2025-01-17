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
    @Published var activities = [Activity]()
    @Published var workouts = [Workout]()
    
    var mockActivities = [
        Activity(title: "Today Steps", subtitle: "Goal 10,000", image: "figure.walk", color: .green, amount: "9,123"),
        Activity(title: "Today Steps", subtitle: "Goal 10,000", image: "figure.walk", color: .green, amount: "30,423"),
        Activity(title: "Today Steps", subtitle: "Goal 10,000", image: "figure.walk", color: .green, amount: "5,653"),
        Activity(title: "Today Steps", subtitle: "Goal 10,000", image: "figure.run", color: .green, amount: "123,123")
    ]
    
    var mockWorkout = [
        Workout(id: 0, title: "Running", tintColor: .green, date: "Aug 31", duration: "32 mins", image: "figure.run", calories: "476 Kcal"),
        Workout(id: 1, title: "Badminton", tintColor: .blue, date: "Aug 31", duration: "20 mins", image: "figure.badminton", calories: "476 Kcal"),
        Workout(id: 2, title: "Walking", tintColor: .purple, date: "Aug 31", duration: "50 mins", image: "figure.walk", calories: "476 Kcal"),
        Workout(id: 3, title: "Running", tintColor: .green, date: "Aug 31", duration: "34 mins", image: "figure.run", calories: "476 Kcal"),
        Workout(id: 4, title: "Running", tintColor: .green, date: "Aug 31", duration: "53 mins", image: "figure.run", calories: "476 Kcal")
    ]
    
    init() {
        Task {
            do {
                try await healthManager.requestHealthKitAccess()
                fetchTodayCalories()
                fetchTodayExerciseTime()
                fetchTodayStandHours()
                fetchTodaySteps()
                fetchRecentWorkout()
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
                    let activity = Activity(title: "Today steps", subtitle: "Goals: 800", image: "flame", color: .red, amount: calories.formattedNumberString())
                    self.activities.append(activity)
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
    func fetchTodaySteps() {
        healthManager.fetchTodaySteps { result in
            switch result {
            case .success(let activity):
                DispatchQueue.main.async {
                    self.activities.append(activity)
                }
            case .failure(let failure):
                print("DEBUG: \(failure.localizedDescription)")
            }
        }
    }
    func fetchCurrentWeekActivities() {
        healthManager.fetchCurrentWeekWorkoutStats { result in
            switch result {
            case .success(let activities):
                DispatchQueue.main.async {
                    self.activities.append(contentsOf: activities)
                }
            case .failure(let failure):
                print("DEBUG: \(failure.localizedDescription)")
            }
        }
    }
    func fetchRecentWorkout() {
        healthManager.fetchWorkoutsForMonth(month: Date()) { result in
            switch result {
            case .success(let workouts):
                DispatchQueue.main.async {
                    self.workouts = Array(workouts.prefix(4))
                }
            case .failure(let failure):
                print("DEBUG: \(failure.localizedDescription)")
            }
        }
    }
}
