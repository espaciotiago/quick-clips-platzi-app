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
            } else if let error = self.viewModel.error {
                ErrorView(error)
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
                    .edgesIgnoringSafeArea(.all)
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
                    }.onAppear {
                        if self.viewModel.isLastLoadedClip(clipCardVM.clip),
                           !self.viewModel.showingFromCache {
                            Task {
                                self.viewModel.loadingPage = true
                                await self.viewModel.getFeed()
                            }
                        }
                    }
                }
                if self.viewModel.loadingPage {
                    ProgressView().tint(Color(.font))
                }
            }
        }
    }
    
    private var LoadingView: some View {
        VStack {
            Spacer()
            ProgressView().tint(Color(.font))
            Spacer()
        }.padding()
    }
    
    private var EmptyView: some View {
        VStack(spacing: 16) {
            Spacer()
            Text("No hay datos para mostrar")
                .font(.subheadline)
                .foregroundStyle(Color(.font))
                .multilineTextAlignment(.center)
            CustomButtonView(label: "Reintentar") {
                Task {
                    self.viewModel.loading = true
                    await self.viewModel.getFeed()
                }
            }
            Spacer()
        }.padding()
    }
    
    private func ErrorView(_ error: Error) -> some View {
        VStack(spacing: 16) {
            Spacer()
            Text(error.localizedDescription)
                .font(.subheadline)
                .foregroundStyle(Color(.font))
                .multilineTextAlignment(.center)
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

#Preview("With connection") {
    NavigationStack {
        ClipsFeedView(viewModel: ClipsFeedViewModel(getClipsUseCase: GetClipsUseCase(remoteDataSource: GetClipsMockDataSource(),
                                                                                     localDataSource: GetClipsMockDataSource(isRemote: false),
                                                                                     networkMonitor: MockNetworkMonitor()),
                                                    cacheLatestClipsUseCase: CacheLatestClipsUseCase(localCacheLatestClipsDataSource: MockCacheLatestClipsDataSource())))
    }
}

#Preview("Without connection") {
    NavigationStack {
        ClipsFeedView(viewModel: ClipsFeedViewModel(getClipsUseCase: GetClipsUseCase(remoteDataSource: GetClipsMockDataSource(),
                                                                                     localDataSource: GetClipsMockDataSource(isRemote: false),
                                                                                     networkMonitor: MockNetworkMonitor(hasConnection: false)),
                                                    cacheLatestClipsUseCase: CacheLatestClipsUseCase(localCacheLatestClipsDataSource: MockCacheLatestClipsDataSource())))
    }
}

#Preview("Error") {
    NavigationStack {
        ClipsFeedView(viewModel: ClipsFeedViewModel(getClipsUseCase: GetClipsUseCase(remoteDataSource: GetClipsMockDataSource(error: NSError(domain: "Something went wrong",
                                                                                                                                             code: 400)),
                                                                                     localDataSource: GetClipsMockDataSource(isRemote: false),
                                                                                     networkMonitor: MockNetworkMonitor()),
                                                    cacheLatestClipsUseCase: CacheLatestClipsUseCase(localCacheLatestClipsDataSource: MockCacheLatestClipsDataSource())))
    }
}

#Preview("Empty") {
    NavigationStack {
        ClipsFeedView(viewModel: ClipsFeedViewModel(getClipsUseCase: GetClipsUseCase(remoteDataSource: GetClipsMockDataSource(feed: []),
                                                                                     localDataSource: GetClipsMockDataSource(isRemote: false),
                                                                                     networkMonitor: MockNetworkMonitor()),
                                                    cacheLatestClipsUseCase: CacheLatestClipsUseCase(localCacheLatestClipsDataSource: MockCacheLatestClipsDataSource())))
    }
}
