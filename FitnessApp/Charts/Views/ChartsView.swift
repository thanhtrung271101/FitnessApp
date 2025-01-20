//
//  HistoricDataView.swift
//  FitnessApp
//
//  Created by Thành Trung on 31/12/24.
//

import SwiftUI
import Charts

struct DailyStepModel: Identifiable {
    let id = UUID()
    let date: Date
    let count: Double
}

enum ChartOptions: String, CaseIterable {
    case oneWeek = "1W"
    case oneMonth = "1M"
    case threeMonth = "3M"
    case yearToDate = "YTD"
    case oneYear = "1Y"
}

class ChartsViewModel: ObservableObject {
    var mockData = [
        DailyStepModel(date: Date(), count: 42343),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(), count: 12345),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(), count: 21535),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -3, to: Date()) ?? Date(), count: 34425),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -4, to: Date()) ?? Date(), count: 41135),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -5, to: Date()) ?? Date(), count: 21453),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -6, to: Date()) ?? Date(), count: 12345),
    ]
    
    @Published var mockOneMonthData = [DailyStepModel]()
    @Published var mockThreeMonthData = [DailyStepModel]()
    @Published var mockOneYearData = [DailyStepModel]()
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
            let dailyStepData = DailyStepModel(date: date, count: Double(count))
            mockData.append(dailyStepData)
        }
        return mockData
    }
}

struct ChartsView: View {
    @StateObject var viewModel = ChartsViewModel()
    @State var seletedChart: ChartOptions = .oneWeek
    var body: some View {
        VStack() {
            Text("Charts")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            ZStack {
                switch seletedChart {
                case .oneWeek:
                    Chart {
                        ForEach(viewModel.mockData) { data in
                            BarMark(x: .value(data.date.formatted(), data.date, unit: .day), y: .value("Steps", data.count))
                        }
                    }
                case .oneMonth:
                    Chart {
                        ForEach(viewModel.mockOneMonthData) { data in
                            BarMark(x: .value(data.date.formatted(), data.date, unit: .day), y: .value("Steps", data.count))
                        }
                    }
                case .threeMonth:
                    Chart {
                        ForEach(viewModel.mockThreeMonthData) { data in
                            BarMark(x: .value(data.date.formatted(), data.date, unit: .day), y: .value("Steps", data.count))
                        }
                    }
                case .yearToDate:
                    EmptyView()
                case .oneYear:
                    Chart {
                        ForEach(viewModel.mockOneYearData) { data in
                            BarMark(x: .value(data.date.formatted(), data.date, unit: .day), y: .value("Steps", data.count))
                        }
                    }
                }
            }
            .foregroundStyle(.green)
            .frame(maxHeight: 350)
            .padding(.horizontal)
            
            HStack {
                ForEach(ChartOptions.allCases, id: \.rawValue) { option in
                    Button(option.rawValue) {
                        withAnimation {
                            seletedChart = option
                        }
                    }
                    .padding()
                    .foregroundStyle(seletedChart == option ? .white : .green)
                    .background(seletedChart == option ? .green : .clear)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        
        
    }
}

#Preview {
    ChartsView()
}
