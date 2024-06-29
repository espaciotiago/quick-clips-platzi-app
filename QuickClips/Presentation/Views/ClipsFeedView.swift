//
//  ClipsFeedView.swift
//  QuickClips
//
//  Created by Santiago Moreno on 29/06/24.
//

import SwiftUI

struct ClipsFeedView: View {
    
    @StateObject var viewModel: ClipsFeedViewModel
    
    var body: some View {
        ZStack {
            Color(.primary).edgesIgnoringSafeArea(.all)
            ScrollView {
                LazyVStack(spacing: 32) {
                    ClipCardView(viewModel: ClipCardViewModel(clip: Clip(id: 0,
                                                                         imageUrl: "https://images.pexels.com/videos/1526909/free-video-1526909.jpg?auto=compress&cs=tinysrgb&fit=crop&h=630&w=1200",
                                                                         videoUrl: "https://videos.pexels.com/video-files/1526909/1526909-hd_1280_720_24fps.mp4",
                                                                         user: UserClip(id: 1,
                                                                                        name: "Jhon Doe",
                                                                                        profileUrl: "https://www.pexels.com/@digitech"))),
                                 clipSelected: { clip in
                        self.viewModel.selectClip(clip)
                    }, profileSelected: { url in
                        self.viewModel.showProfileUrl(url)
                    })
                }.padding()
            }
        }
        .navigationTitle("QuickClips")
        .navigationDestination(item: self.$viewModel.selectedClip, destination: { clip in
            ClipDetailView(viewModel: ClipDetailViewModel(clip: clip))
        })
        .sheet(item: self.$viewModel.sheet) { item in
            switch item {
            case .safariView(let url):
                SafariView(url: url)
            }
        }
    }
}

#Preview {
    ClipsFeedView(viewModel: ClipsFeedViewModel())
}
