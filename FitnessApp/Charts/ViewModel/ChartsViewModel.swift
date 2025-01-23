//
//  ChartsViewModel.swift
//  FitnessApp
//
//  Created by Thành Trung on 23/1/25.
//

import Foundation

class ChartsViewModel: ObservableObject {
    var mockWeekChartData = [
        DailyStepModel(date: Date(), count: 42343),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(), count: 12345),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(), count: 21535),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -3, to: Date()) ?? Date(), count: 34425),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -4, to: Date()) ?? Date(), count: 41135),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -5, to: Date()) ?? Date(), count: 21453),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -6, to: Date()) ?? Date(), count: 12345),
    ]
    
    var mockChartData = [
        MonthlyStepModel(date: Date(), count: 42524),
        MonthlyStepModel(date: Calendar.current.date(byAdding: .month, value: -1, to: Date()) ?? Date(), count: 53872),
        MonthlyStepModel(date: Calendar.current.date(byAdding: .month, value: -2, to: Date()) ?? Date(), count: 43324),
        MonthlyStepModel(date: Calendar.current.date(byAdding: .month, value: -3, to: Date()) ?? Date(), count: 63324),
        MonthlyStepModel(date: Calendar.current.date(byAdding: .month, value: -4, to: Date()) ?? Date(), count: 73324),
        MonthlyStepModel(date: Calendar.current.date(byAdding: .month, value: -5, to: Date()) ?? Date(), count: 23324),
        MonthlyStepModel(date: Calendar.current.date(byAdding: .month, value: -6, to: Date()) ?? Date(), count: 33324),
        MonthlyStepModel(date: Calendar.current.date(byAdding: .month, value: -7, to: Date()) ?? Date(), count: 43324),
        MonthlyStepModel(date: Calendar.current.date(byAdding: .month, value: -8, to: Date()) ?? Date(), count: 53324),
        MonthlyStepModel(date: Calendar.current.date(byAdding: .month, value: -9, to: Date()) ?? Date(), count: 63324),
        MonthlyStepModel(date: Calendar.current.date(byAdding: .month, value: -10, to: Date()) ?? Date(), count: 43324),
        MonthlyStepModel(date: Calendar.current.date(byAdding: .month, value: -11, to: Date()) ?? Date(), count: 43324),
    ]
    
    @Published var oneWeekAverage = 1123
    @Published var oneWeekTotal = 8993
    
    @Published var mockOneMonthData = [DailyStepModel]()
    @Published var oneMonthAverage = 2320
    @Published var oneMonthTotal = 50425
    
    @Published var mockThreeMonthData = [DailyStepModel]()
    @Published var threeMonthAverage = 2320
    @Published var threeMonthTotal = 150425
    
    @Published var ytdAverage = 43535
    @Published var ytdTotal = 1533533
    
    @Published var mockOneYearData = [DailyStepModel]()
    @Published var oneYearAverage = 124323
    @Published var oneYearTotal = 2313534
    
    init() {
        let mockOneMonth = self.mockDataForDays(days: 30)
        let mockThreeMonths = self.mockDataForDays(days: 90)
        let mockOneYear = self.mockDataForDays(days: 365)
        DispatchQueue.main.async {
            self.mockOneMonthData = mockOneMonth
            self.mockThreeMonthData = mockThreeMonths
            self.mockOneYearData = mockOneYear
        }
    }
    func mockDataForDays(days: Int) -> [DailyStepModel] {
        var mockData = [DailyStepModel]()
        for day in 0..<days {
            let date = Calendar.current.date(byAdding: .day, value: -day, to: Date()) ?? Date()
            let count = Int.random(in: 5000...15000)
            let dailyStepData = DailyStepModel(date: date, count: count)
            mockData.append(dailyStepData)
        }
        return mockData
    }
}
