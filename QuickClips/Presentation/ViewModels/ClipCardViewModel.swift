//
//  ClipCardViewModel.swift
//  QuickClips
//
//  Created by Santiago Moreno on 29/06/24.
//

import Foundation

struct ClipCardViewModel: Identifiable {
    
    let id = UUID()
    
    let clip: Clip
    
    var imageUrl: String {
        return self.clip.imageUrl
    }
    
    var userClip: UserClip {
        return self.clip.user
    }
}
