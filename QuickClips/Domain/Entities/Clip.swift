//
//  Clip.swift
//  QuickClips
//
//  Created by Santiago Moreno on 29/06/24.
//

import Foundation

struct Clip {
    let id: Int
    let imageUrl: String
    let videoUrl: String
    let user: UserClip
}

extension Clip: Hashable {
    static func == (lhs: Clip, rhs: Clip) -> Bool {
        return lhs.id == rhs.id
    }
}
