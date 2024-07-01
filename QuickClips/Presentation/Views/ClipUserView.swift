//
//  ClipUserView.swift
//  QuickClips
//
//  Created by Santiago Moreno on 29/06/24.
//

import SwiftUI

struct ClipUserView: View {
    
    let viewModel: ClipUserViewModel
    let action: (URL?) -> Void
    
    var body: some View {
        HStack {
            UrlImageView(urlString: self.viewModel.profileImageUrl)
                .frame(width: 32, height: 32)
                .clipShape(Circle())
            Text(self.viewModel.name)
                .font(.subheadline)
                .foregroundStyle(Color(.font))
            Spacer()
            CustomButtonView(label: Translations.seeProfileButton) {
                self.action(self.viewModel.profileUrl)
            }
        }.padding(.horizontal)
    }
}

#Preview {
    ClipUserView(viewModel: ClipUserViewModel(userClip: UserClip(id: 1,
                                                                 name: "Jhon Doe",
                                                                 profileUrl: "https://www.pexels.com/@digitech"))) { _ in }
        .padding()
        .background(Color(.primary))
}
