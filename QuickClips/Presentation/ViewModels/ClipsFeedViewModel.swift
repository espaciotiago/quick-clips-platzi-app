//
//  ClipsFeedViewModel.swift
//  QuickClips
//
//  Created by Santiago Moreno on 29/06/24.
//

import Foundation
import Combine

enum ClipsFeedSheet: Identifiable, Equatable {
    var id: UUID { UUID() }
    case safariView(url: URL)
}

class ClipsFeedViewModel: ObservableObject {
    
    @Published var loading = true
    @Published var loadingPage = true
    @Published var sheet: ClipsFeedSheet?
    @Published var selectedClip: Clip?
    let limit = 10
    var page = 1
    var showingFromCache = false
    var feed = [ClipCardViewModel]()
    var error: Error?
    
    private let getClipsUseCase: GetClipsUseCaseProtocol
    private let cacheLatestClipsUseCase: CacheLatestClipsProtocol
    
    init(getClipsUseCase: GetClipsUseCaseProtocol,
         cacheLatestClipsUseCase: CacheLatestClipsProtocol) {
        self.getClipsUseCase = getClipsUseCase
        self.cacheLatestClipsUseCase = cacheLatestClipsUseCase
    }
    
    var shouldShowEmptyView: Bool {
        return self.feed.isEmpty
    }
    
    func getFeed() async {
        do {
            let result = try await self.getClipsUseCase.execute(page: self.page, limit: self.limit)
            switch result {
            case .success(let response):
                self.feed.append(contentsOf: response.clips.map {ClipCardViewModel(clip: $0)})
                if response.shouldCacheClips {
                    self.showingFromCache = false
                    self.cacheLatestClipsUseCase.execute(response.clips)
                } else {
                    self.showingFromCache = true
                }
                self.page += 1
            case .failure(let error):
                self.error = error
            }
        } catch {
            self.error = error
        }
        self.hideLoading()
    }
    
    func isLastLoadedClip(_ clip: Clip) -> Bool {
        return clip == self.feed.last?.clip
    }
    
    func selectClip(_ clip: Clip) {
        self.selectedClip = clip
    }
    
    func showProfileUrl(_ url: URL?) {
        guard let url = url else {
            return
        }
        self.sheet = .safariView(url: url)
    }
    
    private func hideLoading() {
        DispatchQueue.main.async {
            if self.loading {
                self.loading = false
            } else if self.loadingPage {
                self.loadingPage = false
            }
        }
    }
}
