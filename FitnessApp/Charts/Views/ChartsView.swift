//
//  HistoricDataView.swift
//  FitnessApp
//
//  Created by Thành Trung on 31/12/24.
//

import SwiftUI
import Charts

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
                    VStack {
                        ChartDataView(average: viewModel.oneWeekAverage, total: viewModel.oneWeekTotal)
                        Chart {
                            ForEach(viewModel.mockWeekChartData) { data in
                                BarMark(x: .value(data.date.formatted(), data.date, unit: .day), y: .value("Steps", data.count))
                            }
                        }
                    }
                case .oneMonth:
                    VStack {
                        ChartDataView(average: viewModel.oneMonthAverage, total: viewModel.oneMonthTotal)
                        Chart {
                            ForEach(viewModel.mockOneMonthData) { data in
                                BarMark(x: .value(data.date.formatted(), data.date, unit: .day), y: .value("Steps", data.count))
                            }
                        }
                    }
                case .threeMonth:
                    VStack {
                        ChartDataView(average: viewModel.threeMonthAverage, total: viewModel.threeMonthTotal)
                        Chart {
                            ForEach(viewModel.mockThreeMonthData) { data in
                                BarMark(x: .value(data.date.formatted(), data.date, unit: .day), y: .value("Steps", data.count))
                            }
                        }
                    }
                case .yearToDate:
                    VStack {
                        ChartDataView(average: viewModel.ytdAverage, total: viewModel.ytdTotal)
                        Chart {
                            ForEach(viewModel.mockChartData) { data in
                                BarMark(x: .value(data.date.formatted(), data.date, unit: .month), y: .value("Steps", data.count))
                            }
                        }
                    }
                case .oneYear:
                    VStack {
                        ChartDataView(average: viewModel.oneYearAverage, total: viewModel.oneYearTotal)
                        Chart {
                            ForEach(viewModel.mockOneYearData) { data in
                                BarMark(x: .value(data.date.formatted(), data.date, unit: .day), y: .value("Steps", data.count))
                            }
                        }
                    }
                }
            }
            .foregroundStyle(.green)
            .frame(maxHeight: 450)
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
