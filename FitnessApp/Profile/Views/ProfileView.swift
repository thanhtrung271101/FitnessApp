//
//  ProfileView.swift
//  FitnessApp
//
//  Created by Thành Trung on 16/2/25.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage("profileName") var profileName: String?
    @AppStorage("profileImage") var profileImage: String?
    @State private var images = [
        "oldman", "ambessa", "darius", "draven", "ironman", "hulk", "caitlyn", "liss", "elise", "gagi", "steve", "tom", "black"
    ]
    @State private var isEditingName = true
    @State private var currentName = ""
    @State private var isEditingImage = false
    @State private var seletedImage: String?
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                Image(profileImage ?? "oldman")
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
                            isEditingName = false
                            isEditingImage = true
                        }
                    }
                VStack(alignment: .leading) {
                    Text("Good morning,")
                        .font(.largeTitle)
                        .foregroundStyle(.gray)
                        .minimumScaleFactor(0.5)
                    
                    Text(profileName ?? "Name")
                        .font(.title)
                }
            }
            if isEditingName {
                VStack {
                    TextField("Name ...", text: $currentName)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke()
                        )
                    HStack {
                        FitnessProfileEditButton(title: "Cancel", backgroundColor: .gray.opacity(0.1)) {
                            withAnimation {
                                isEditingName = false
                            }
                        }
                        .foregroundStyle(.red)
                        FitnessProfileEditButton(title: "Done", backgroundColor: .primary) {
                            if !currentName.isEmpty {
                                withAnimation {
                                    profileName = currentName
                                    isEditingName = false
                                }
                            }
                        }
                        .foregroundStyle(Color(uiColor: .systemBackground))
                    }
                }
            }
            if isEditingImage {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(images, id: \.self) { image in
                            Button {
                                withAnimation {
                                    seletedImage = image
                                }
                            } label: {
                                VStack {
                                    Image(image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .onTapGesture {
                                            seletedImage = image
                                        }
                                    if seletedImage == image {
                                        Circle()
                                            .frame(width: 16, height: 16)
                                            .foregroundStyle(.primary)
                                    }
                                }
                                .padding()
                            }
                        }
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.gray.opacity(0.25))
                )
                
                Button {
                    withAnimation {
                        profileImage = seletedImage
                        isEditingImage = false
                    }
                } label: {
                    Text("Done")
                        .padding()
                        .frame(maxWidth: 200)
                        .foregroundStyle(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.black)
                        )
                }
                .padding(.bottom)
            }
            VStack {
                FitnessProfileItemButton(title: "Edit name", image: "square.and.pencil") {
                    withAnimation {
                        isEditingName = true
                        isEditingImage = false
                    }
                }
                FitnessProfileItemButton(title: "Edit image", image: "square.and.pencil") {
                    withAnimation {
                        isEditingImage = true
                        isEditingName = false
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
        .onAppear {
            seletedImage = profileImage
        }
    }
}

#Preview {
    ProfileView()
}
