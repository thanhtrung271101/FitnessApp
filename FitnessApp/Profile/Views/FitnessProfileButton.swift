//
//  FitnessProfileButton.swift
//  FitnessApp
//
//  Created by Thành Trung on 16/2/25.
//

import SwiftUI

struct FitnessProfileButton: View {
    @State var title: String
    @State var image: String
    var action: (() -> Void)
    var body: some View {
        Button {
            print("\(title)")
        } label: {
            HStack {
                Image(systemName: image)
                Text("\(title)")
            }
            .foregroundStyle(.black)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    FitnessProfileButton(title: "Edit name", image: "square.and.pencil") {}
}
