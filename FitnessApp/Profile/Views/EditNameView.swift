//
//  EditNameView.swift
//  FitnessApp
//
//  Created by Thành Trung on 18/2/25.
//

import SwiftUI

struct EditNameView: View {
    @ObservedObject var viewModel: ProfileViewModel

    var body: some View {
        VStack {
            TextField("Name ...", text: $viewModel.currentName)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke()
                )
            HStack {
                FitnessProfileEditButton(title: "Cancel", backgroundColor: .gray.opacity(0.1)) {
                    withAnimation {
                        viewModel.dismissEdit()
                    }
                }
                .foregroundStyle(.red)
                FitnessProfileEditButton(title: "Done", backgroundColor: .primary) {
                    if !viewModel.currentName.isEmpty {
                        withAnimation {
                            viewModel.setNewName()
                        }
                    }
                }
                .foregroundStyle(Color(uiColor: .systemBackground))
            }
        }
    }
}


#Preview {
    EditNameView(viewModel: .init())
}
