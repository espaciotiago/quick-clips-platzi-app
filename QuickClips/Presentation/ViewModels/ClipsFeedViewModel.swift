//
//  ClipsFeedViewModel.swift
//  QuickClips
//
//  Created by Santiago Moreno on 29/06/24.
//

import Foundation
import Combine

enum ClipsFeedSheet: Identifiable {
    var id: UUID { UUID() }
    case safariView(url: URL)
}

class ClipsFeedViewModel: ObservableObject {
    
    @Published var loading = true
    @Published var sheet: ClipsFeedSheet?
    @Published var selectedClip: Clip?
    let limit = 10
    var page = 0
    var feed = [ClipCardViewModel]()
    var error: Error?
    
    private let getClipsUseCase: GetClipsUseCase
    
    init(getClipsUseCase: GetClipsUseCase) {
        self.getClipsUseCase = getClipsUseCase
    }
    
    var shouldShowEmptyView: Bool {
        return feed.isEmpty
    }
    
    func getFeed() async {
        do {
            let result = try await self.getClipsUseCase.execute(page: self.page, limit: self.limit)
            switch result {
            case .success(let clips):
                DispatchQueue.main.async {
                    self.feed = clips.map {ClipCardViewModel(clip: $0)}
                    self.loading = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.error = error
                    self.loading = false
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.error = error
                self.loading = false
            }
        }
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
}
