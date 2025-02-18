//
//  ProfileHeaderView.swift
//  FitnessApp
//
//  Created by Thành Trung on 18/2/25.
//

import SwiftUI

struct ProfileHeaderView: View {
    @ObservedObject var viewModel: ProfileViewModel

    var body: some View {
        HStack(spacing: 16) {
                    Image(viewModel.profileImage ?? "oldman")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding(.all, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.gray.opacity(0.25))
                        )
                        .onTapGesture {
                            withAnimation {
                                viewModel.presentEditImage()
                            }
                        }
                    VStack(alignment: .leading) {
                        Text("Good morning,")
                            .font(.largeTitle)
                            .foregroundStyle(.gray)
                            .minimumScaleFactor(0.5)
                        
                        Text(viewModel.profileName ?? "Name")
                            .font(.title)
                    }
                }
    }
}

#Preview {
    ProfileHeaderView(viewModel: .init())
}
