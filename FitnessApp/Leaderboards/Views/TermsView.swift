//
//  TermsView.swift
//  FitnessApp
//
//  Created by Thành Trung on 24/1/25.
//

import SwiftUI

struct TermsView: View {
    @AppStorage("userName") var userName: String?
    @State var name = ""
    @State var acceptedTerms = false
    @Binding var showTerms: Bool
    var body: some View {
        VStack {
            Text("Leaderboard")
                .font(.largeTitle)
                .bold()
            Spacer()
            TextField("User name", text: $name)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke()
                )
            HStack(alignment: .top) {
                Button {
                    withAnimation {
                        acceptedTerms.toggle()
                    }
                } label: {
                    if acceptedTerms {
                        Image(systemName: "square.inset.filled")
                    } else {
                        Image(systemName: "square")
                    }
                }
                Text("By checking you agree to the terms and enter into the leaderboard competition.")
            }
            Spacer()
            Button {
                if acceptedTerms && name.count > 2 {
                    userName = name
                    showTerms = false
                }
            } label: {
                Text("Continue")
                    .foregroundStyle(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                    )
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    TermsView(showTerms: .constant(true))
}
