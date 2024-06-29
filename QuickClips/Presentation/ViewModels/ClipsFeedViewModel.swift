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
    
    @Published var sheet: ClipsFeedSheet?
    @Published var selectedClip: Clip?
    
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
