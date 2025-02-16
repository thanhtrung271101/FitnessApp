//
//  ProfileView.swift
//  FitnessApp
//
//  Created by Thành Trung on 16/2/25.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                Image("oldman")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding(.all, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.gray.opacity(0.25))
                    )
                VStack(alignment: .leading) {
                    Text("Good morning")
                        .font(.largeTitle)
                        .foregroundStyle(.gray)
                    Text("Name")
                        .font(.title)
                }
                
            }
            VStack {
                FitnessProfileButton(title: "Edit name", image: "square.and.pencil") {
                    print("Edit name")
                }
                FitnessProfileButton(title: "Edit image", image: "square.and.pencil") {
                    print("Edit image")
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.gray.opacity(0.15))
            )
            .padding(.vertical)
            VStack {
                FitnessProfileButton(title: "Contact Us", image: "envelope") {
                    print("Contact Us")
                }
                FitnessProfileButton(title: "Privacy", image: "doc") {
                    print("Privacy")
                }
                FitnessProfileButton(title: "Terms of Service", image: "doc") {
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
