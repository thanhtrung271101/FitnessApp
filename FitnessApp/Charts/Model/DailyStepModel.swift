//
//  DailyStepModel.swift
//  FitnessApp
//
//  Created by Thành Trung on 23/1/25.
//

import Foundation

struct DailyStepModel: Identifiable {
    let id = UUID()
    let date: Date
    let count: Int
}
