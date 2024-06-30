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
            if self.viewModel.loading {
                LoadingView
            } else if self.viewModel.shouldShowEmptyView {
                EmptyView
            } else {
                FeedView
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
        .onAppear {
            Task {
                await self.viewModel.getFeed()
            }
        }
    }
    
    private var FeedView: some View {
        ScrollView {
            LazyVStack(spacing: 32) {
                ForEach(self.viewModel.feed) { clipCardVM in
                    ClipCardView(viewModel: clipCardVM) { clip in
                        self.viewModel.selectClip(clip)
                    } profileSelected: { url in
                        self.viewModel.showProfileUrl(url)
                    }
                }
            }.padding()
        }
    }
    
    private var LoadingView: some View {
        VStack {
            Spacer()
            ProgressView()
                .tint(Color(.font))
            Spacer()
        }.padding()
    }
    
    private var EmptyView: some View {
        VStack(spacing: 16) {
            Spacer()
            Text("No hay datos para mostrar")
                .font(.subheadline)
                .foregroundStyle(Color(.font))
            CustomButtonView(label: "Reintentar") {
                Task {
                    self.viewModel.loading = true
                    await self.viewModel.getFeed()
                }
            }
            Spacer()
        }.padding()
    }
}

#Preview {
    ClipsFeedView(viewModel: ClipsFeedViewModel(getClipsUseCase: GetClipsUseCase(remoteDataSource: GetClipsRemoteDataSource(),
                                                                                 localDataSource: GetClipsLocalDataSource(),
                                                                                 networkMonitor: NetworkMonitor())))
}
