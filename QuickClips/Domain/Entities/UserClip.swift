//
//  UserClip.swift
//  QuickClips
//
//  Created by Santiago Moreno on 29/06/24.
//

import Foundation

struct UserClip {
    let id: Int
    let name: String
    let profileUrl: String
}

extension UserClip: Hashable {
    static func == (lhs: UserClip, rhs: UserClip) -> Bool {
        return lhs.id == rhs.id
    }
}
