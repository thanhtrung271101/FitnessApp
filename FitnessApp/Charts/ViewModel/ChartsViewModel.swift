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
    
    @Published var ytdChartData = [MonthlyStepModel]()
    @Published var ytdAverage = 0
    @Published var ytdTotal = 0
    
    @Published var oneYearChartData = [MonthlyStepModel]()
    @Published var mockOneYearData = [DailyStepModel]()
    @Published var oneYearAverage = 0
    @Published var oneYearTotal = 0
    
    let healthManager = HealthManager.shared
    
    init() {
        let mockOneMonth = self.mockDataForDays(days: 30)
        let mockThreeMonths = self.mockDataForDays(days: 90)
        DispatchQueue.main.async {
            self.mockOneMonthData = mockOneMonth
            self.mockThreeMonthData = mockThreeMonths
        }
        fetchYTDAndOneYearChartData()
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
    
    func fetchYTDAndOneYearChartData() {
        healthManager.fetchYTDAndOneYearChartData { result in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    self.ytdChartData = result.ytd
                    self.oneYearChartData = result.oneYear
                    
                    self.ytdTotal = self.ytdChartData.reduce(0, { $0 + $1.count})
                    self.oneYearTotal = self.oneYearChartData.reduce(0, { $0 + $1.count})
                    
                    self.ytdAverage = self.ytdTotal / Calendar.current.component(.month, from: Date())
                    self.oneYearAverage = self.oneYearTotal / 12
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
