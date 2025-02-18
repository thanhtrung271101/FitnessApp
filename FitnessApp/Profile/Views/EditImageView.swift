//
//  EditImageView.swift
//  FitnessApp
//
//  Created by Thành Trung on 18/2/25.
//

import SwiftUI

struct EditImageView: View {
    @ObservedObject var viewModel: ProfileViewModel

    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.images, id: \.self) { image in
                        Button {
                            withAnimation {
                                viewModel.didSelectNewImage(name: image)
                            }
                        } label: {
                            VStack {
                                Image(image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                if viewModel.selectedImage == image {
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
            
            FitnessProfileEditButton(title: "Done", backgroundColor: .primary){
                withAnimation {
                    viewModel.setNewImage()
                }
            }
            .padding(.bottom)
        }
    }
}

#Preview {
    EditImageView(viewModel: ProfileViewModel())
}
