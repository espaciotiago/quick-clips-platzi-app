//
//  ClipCardView.swift
//  QuickClips
//
//  Created by Santiago Moreno on 29/06/24.
//

import SwiftUI

struct ClipCardView: View {
    
    let viewModel: ClipCardViewModel
    let clipSelected: (Clip) -> Void
    let profileSelected: (URL?) -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Button(action: {
                self.clipSelected(self.viewModel.clip)
            }, label: {
                ZStack {
                    UrlImageView(urlString: self.viewModel.imageUrl)
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: 240)
                        .clipped()
                    Image(.playButton)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(Color(.placeholder))
                        .frame(width: 40, height: 40)
                }
            })
            ClipUserView(viewModel: ClipUserViewModel(userClip: self.viewModel.userClip)) { url in
                self.profileSelected(url)
            }.padding(.horizontal)
        }
    }
}

#Preview {
    ClipCardView(viewModel: ClipCardViewModel(clip: Clip(id: 0,
                                                         imageUrl: "https://images.pexels.com/videos/1526909/free-video-1526909.jpg?auto=compress&cs=tinysrgb&fit=crop&h=630&w=1200",
                                                         videoUrl: "https://videos.pexels.com/video-files/1526909/1526909-hd_1280_720_24fps.mp4",
                                                         user: UserClip(id: 1,
                                                                        name: "Jhon Doe",
                                                                        profileUrl: "https://www.pexels.com/@digitech"))),
                 clipSelected: { _ in },
                 profileSelected: { _ in })
    .padding()
    .background(Color(.primary))
}
