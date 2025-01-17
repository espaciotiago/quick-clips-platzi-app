//
//  ClipDetailView.swift
//  QuickClips
//
//  Created by Santiago Moreno on 29/06/24.
//

import SwiftUI
import AVKit

struct ClipDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: ClipDetailViewModel
    
    var body: some View {
        ZStack {
            Color(.primary).edgesIgnoringSafeArea(.all)
            VStack(spacing: 8) {
                VStack {
                    if let player = self.viewModel.player {
                        VideoPlayer(player: player)
                            .onAppear {
                                player.play()
                            }
                            .frame(maxWidth: .infinity)
                    } else {
                        Spacer()
                        ProgressView()
                            .tint(Color(.font))
                        Spacer()
                    }
                }
                Spacer()
                ClipUserView(viewModel: ClipUserViewModel(userClip: self.viewModel.userClip)) { url in
                    self.viewModel.showProfileUrl(url)
                }
                Spacer().frame(height: 24)
            }
        }
        .accessibilityIdentifier("ClipDetailView")
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(Translations.detailNavigationTitle)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color(.font))
            }
        })
        .onAppear {
            DispatchQueue.main.async {
                self.viewModel.loadVideo()
            }
            
        }
        .sheet(item: self.$viewModel.sheet) { item in
            switch item {
            case .safariView(let url):
                SafariView(url: url)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

#Preview {
    ClipDetailView(viewModel: ClipDetailViewModel(clip: Clip(id: 0,
                                                             imageUrl: "https://images.pexels.com/videos/1526909/free-video-1526909.jpg?auto=compress&cs=tinysrgb&fit=crop&h=630&w=1200",
                                                             videoUrl: "https://videos.pexels.com/video-files/1526909/1526909-hd_1280_720_24fps.mp4",
                                                             user: UserClip(id: 1,
                                                                            name: "Jhon Doe",
                                                                            profileUrl: "https://www.pexels.com/@digitech"))))
}
