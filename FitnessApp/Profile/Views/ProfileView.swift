//
//  ProfileView.swift
//  FitnessApp
//
//  Created by Thành Trung on 16/2/25.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        VStack {
            ProfileHeaderView(viewModel: viewModel)
            
            if viewModel.isEditingName {
                EditNameView(viewModel: viewModel)
            }
            
            if viewModel.isEditingImage {
                EditImageView(viewModel: viewModel)
            }
            
            VStack {
                FitnessProfileItemButton(title: "Edit name", image: "square.and.pencil") {
                    withAnimation {
                        viewModel.presentEditName()
                    }
                }
                FitnessProfileItemButton(title: "Edit image", image: "square.and.pencil") {
                    withAnimation {
                        viewModel.presentEditImage()
                    }
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.gray.opacity(0.15))
            )
            .padding(.vertical)

            VStack {
                FitnessProfileItemButton(title: "Contact Us", image: "envelope") {
                    print("Contact Us")
                }
                FitnessProfileItemButton(title: "Privacy", image: "doc") {
                    print("Privacy")
                }
                FitnessProfileItemButton(title: "Terms of Service", image: "doc") {
                    print("Terms of Service")
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.gray.opacity(0.15))
            )
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

#Preview {
    ProfileView()
}
