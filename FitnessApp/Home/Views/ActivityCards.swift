//
//  ActivityCards.swift
//  FitnessApp
//
//  Created by Thành Trung on 1/1/25.
//

import SwiftUI

struct ActivityCards: View {
    @State var activity: Activity
    var body: some View {
        ZStack {
            Color(uiColor: .systemGray6)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8){
                        Text(activity.title)
                        
                        Text(activity.subtitle)
                    }
                    Spacer()
                    Image(systemName: activity.image)
                        .foregroundStyle(Color(.green))
                }
                .padding(.horizontal)
                Text(activity.amount)
                    .font(.title)
                    .fontWeight(.bold)
            }
        }
    }
}

#Preview {
    ActivityCards(activity: Activity(id: 0, title: "Today Steps", subtitle: "Goal 10,000", image: "figure.walk", color: .green, amount: "9,123"))
}
