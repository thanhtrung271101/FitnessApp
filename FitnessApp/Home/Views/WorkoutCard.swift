//
//  WorkoutCard.swift
//  FitnessApp
//
//  Created by Thành Trung on 3/1/25.
//

import SwiftUI

struct WorkoutCard: View {
    @State var workout: Workout
    var body: some View {
        HStack {
            Image(systemName: workout.image)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundStyle(workout.tintColor)
                .padding()
                .background(Color.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            VStack(spacing: 18) {
                HStack {
                    Text(workout.title)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Text(workout.duration)
                        .font(.caption)
                        .foregroundColor(Color.gray)
                }
                HStack {
                    Text(workout.date)
                    Spacer()
                    Text(workout.calories)
                    
                }
                .font(.caption)
                .foregroundStyle(Color.gray)
            }
            .fontWeight(.bold)
        }
        .padding(.horizontal)
    }
}

#Preview {
    WorkoutCard(workout: Workout(id: 0, title: "Running", tintColor: .green, date: "Aug 3", duration: "23 mins", image: "figure.run", calories: "344 Kcal"))
}
