//
//  HealthManager.swift
//  FitnessApp
//
//  Created by Thành Trung on 8/1/25.
//

import Foundation
import HealthKit

class HealthManager {
    
    static let shared = HealthManager()
    let healthStore = HKHealthStore()
    
    private init() {
        Task {
            do {
                try await requestHealthKitAccess()
            } catch {
                print("Error requesting authorization: \(error.localizedDescription)")
            }
        }
    }
    
    func requestHealthKitAccess() async throws {
        let calories = HKQuantityType(.activeEnergyBurned)
        let exercise = HKQuantityType(.appleExerciseTime)
        let stand = HKCategoryType(.appleStandHour)
        let steps = HKQuantityType(.stepCount)
        let workouts = HKSampleType.workoutType()
        let healthTypes: Set = [calories, exercise, stand, steps, workouts]
        try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
    }
    
    func fetchTodayCaloriesBurned(completion: @escaping(Result<Double, Error>) -> Void) {
        let calories = HKQuantityType(.activeEnergyBurned)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: calories, quantitySamplePredicate: predicate) { _, results, error in
            guard let quantity = results?.sumQuantity(), error == nil else {
                completion(.failure(NSError()))
                return
            }
            let caloriesCount = quantity.doubleValue(for: .kilocalorie())
            completion(.success(caloriesCount))
        }
        healthStore.execute(query)
    }
    
    func fetchTodayExcerciseTime(completion: @escaping(Result<Double, Error>) -> Void) {
        let excercise = HKQuantityType(.appleExerciseTime)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: excercise, quantitySamplePredicate: predicate) { _, results, error in
            guard let quantity = results?.sumQuantity(), error == nil else {
                completion(.failure(NSError()))
                return
            }
            let excerciseTime = quantity.doubleValue(for: .minute())
            completion(.success(excerciseTime))
        }
        healthStore.execute(query)
    }
    
    func fetchTodayStandHours(completion: @escaping(Result<Int, Error>) -> Void) {
        let stand = HKCategoryType(.appleStandHour)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKSampleQuery(sampleType: stand, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { _, results, error in
            guard let samples = results as? [HKCategorySample], error == nil else {
                completion(.failure(NSError()))
                return
            }
            let standCount = samples.filter({ $0.value == 0}).count
            completion(.success(standCount))
        }
        healthStore.execute(query)
    }
    
    func fetchTodaySteps(completion: @escaping(Result<Activity, Error>) -> Void) {
        let steps = HKQuantityType(.stepCount)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date(), options: .strictStartDate)
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { _, results, error in
            guard let quantity = results?.sumQuantity(), error == nil else {
                completion(.failure(NSError()))
                return
            }
            let steps = quantity.doubleValue(for: .count())
            let activity = Activity(title: "Today steps", subtitle: "Goals: 800", image: "figure.walk", color: .green, amount: steps.formattedNumberString())
            completion(.success(activity))
        }
        healthStore.execute(query)
    }
    
    func fetchCurrentWeekWorkoutStats(completion: @escaping(Result<[Activity], Error>)-> Void) {
        let workouts = HKSampleType.workoutType()
        let predicate = HKQuery.predicateForSamples(withStart: .startOfWeek, end: Date())
        let query = HKSampleQuery(sampleType: workouts, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { [weak self] _, results, error in
            guard let workouts = results as? [HKWorkout], let self = self, error == nil else {
                completion(.failure(URLError(.badURL)))
                return
            }
            var runningCount: Int = 0
            var swimmingCount: Int = 0
            var cyclingCount: Int = 0
            var walkingCount: Int = 0
            var stairsCount: Int = 0
            var kickboxingCount: Int = 0
            for workout in workouts {
                let duration = Int(workout.duration)/60
                if workout.workoutActivityType == .running {
                    runningCount += duration
                } else if workout.workoutActivityType == . swimming {
                    swimmingCount += duration
                } else if workout.workoutActivityType == .cycling {
                    cyclingCount += duration
                } else if workout.workoutActivityType == .walking {
                    walkingCount += duration
                } else if workout.workoutActivityType == .stairs {
                    stairsCount += duration
                } else if workout.workoutActivityType == .kickboxing {
                    kickboxingCount += duration
                }
            }
            completion(.success(self.generateActivitiesFromDurations(running: runningCount, swimming: swimmingCount, cycling: cyclingCount, walking: walkingCount, stairs: stairsCount, kickboxing: kickboxingCount)))
        }
        healthStore.execute(query)
    }
    
    func generateActivitiesFromDurations(running: Int, swimming: Int, cycling: Int, walking: Int, stairs: Int, kickboxing: Int) -> [Activity] {
        return [
            Activity(title: "Running", subtitle: "This week", image: "figure.run", color: .green, amount: "\(running)"),
            Activity(title: "Swimming", subtitle: "This week", image: "figure.swim", color: .blue, amount: "\(swimming)"),
            Activity(title: "Cycling", subtitle: "This week", image: "figure.cycle", color: .red, amount: "\(cycling)"),
            Activity(title: "Walking", subtitle: "This week", image: "figure.walk", color: .yellow, amount: "\(walking)"),
            Activity(title: "Stairs", subtitle: "This week", image: "figure.stairs", color: .purple, amount: "\(stairs)"),
            Activity(title: "Kickboxing", subtitle: "This week", image: "figure.kickboxing", color: .orange, amount: "\(kickboxing)")
        ]
    }
    
    // MARK: Recent Workouts
    func fetchWorkoutsForMonth(month: Date, completion: @escaping(Result<[Workout], Error>)-> Void) {
        let workouts = HKSampleType.workoutType()
        let (startDate, endDate) = month.fetchMonthStartAndEndDate()
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let query = HKSampleQuery(sampleType: workouts, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { _, results, error in
            guard let workouts = results as? [HKWorkout], error == nil else {
                completion(.failure(URLError(.badURL)))
                return
            }
            let workoutArray = workouts.map( {
                Workout(id: nil, title: $0.workoutActivityType.name,
                        tintColor: $0.workoutActivityType.color,
                        date: $0.startDate.formatWorkoutDate(),
                        duration: "\(Int($0.duration)/60) mins",
                        image: $0.workoutActivityType.image,
                        calories: ($0.totalEnergyBurned?.doubleValue(for: .kilocalorie()).formattedNumberString() ?? "-") + "kcal")})
            completion(.success(workoutArray))
        }
        healthStore.execute(query)
    }
}

// MARK: ChartsView Data
extension HealthManager {
    struct YearChartDataResult {
        let ytd: [MonthlyStepModel]
        let oneYear: [MonthlyStepModel]
    }
    func fetchYTDAndOneYearChartData(completion: @escaping (Result<YearChartDataResult, Error>) -> Void) {
        let steps = HKQuantityType(.stepCount)
        let calendar = Calendar.current
        
        var oneYearMonths = [MonthlyStepModel]()
        var ytdMonths = [MonthlyStepModel]()
        for i in 0...11 {
            let month = calendar.date(byAdding: .month, value: -i, to: Date()) ?? Date()
            let (startOfMonth, endOfMonth) = month.fetchMonthStartAndEndDate()
            let predicate = HKQuery.predicateForSamples(withStart: startOfMonth, end: endOfMonth)
            let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { _, results, error in
                guard let steps = results?.sumQuantity()?.doubleValue(for: .count()), error == nil else {
                    completion(.failure(URLError(.badURL)))
                    return
                }
                if i == 0 {
                    oneYearMonths.append(MonthlyStepModel(date: month, count: Int(steps)))
                    ytdMonths.append(MonthlyStepModel(date: month, count: Int(steps)))
                } else {
                    oneYearMonths.append(MonthlyStepModel(date: month, count: Int(steps)))
                    if calendar.component(.year, from: Date()) == calendar.component(.year, from: month) {
                        ytdMonths.append(MonthlyStepModel(date: month, count: Int(steps)))
                    }
                }
                if i == 11 {
                    completion(.success(YearChartDataResult(ytd: ytdMonths, oneYear: oneYearMonths)))
                }
            }
            healthStore.execute(query)
        }
    }
}

extension HealthManager {
    func fetchCurrentWeekStepCount(completion: @escaping (Result<Double, Error>) -> Void) {
        let steps = HKQuantityType(.stepCount)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfWeek, end: Date())
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { _, results, error in
            guard let quantity = results?.sumQuantity(), error == nil else {
                completion(.failure(URLError(.badURL)))
                return
            }
            
            let steps = quantity.doubleValue(for: .count())
            completion(.success(steps))
        }
        healthStore.execute(query)
        
    }
}
