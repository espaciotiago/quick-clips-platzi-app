//
//  ClipDetailViewModel.swift
//  QuickClips
//
//  Created by Santiago Moreno on 29/06/24.
//

import Foundation
import Combine
import AVKit

enum ClipDetailSheet: Identifiable {
    var id: UUID { UUID() }
    case safariView(url: URL)
}

class ClipDetailViewModel: ObservableObject {
    
    @Published var player: AVPlayer?
    @Published var sheet: ClipDetailSheet?
    
    private let clip: Clip
    
    init(clip: Clip) {
        self.clip = clip
    }
    
    func loadVideo() {
        if let url = URL(string:self.clip.videoUrl) {
            DispatchQueue.main.async {
                self.player = AVPlayer(url: url)
            }
        }
    }
    
    func showProfileUrl(_ url: URL?) {
        guard let url = url else {
            return
        }
        self.sheet = .safariView(url: url)
    }
}
