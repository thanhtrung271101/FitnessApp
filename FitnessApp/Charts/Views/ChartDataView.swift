//
//  ChartDataView.swift
//  FitnessApp
//
//  Created by Thành Trung on 22/1/25.
//

import SwiftUI

struct ChartDataView: View {
    @State var average: Int
    @State var total: Int
    var body: some View {
        HStack() {
            Spacer()
            VStack(spacing: 16) {
                Text("Average")
                    .font(.title2)
                Text("\(average)")
                    .font(.title3)
            }
            .frame(width: 90)
            .foregroundStyle(.black)
            .padding()
            .background(.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            Spacer()
            VStack(spacing: 16) {
                Text("Total")
                    .font(.title2)
                Text("\(total)")
                    .font(.title3)
            }
            .frame(width: 90)
            .foregroundStyle(.black)
            .padding()
            .background(.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            Spacer()
        }
    }
}

#Preview {
    ChartDataView(average: 1234, total: 9898)
}
