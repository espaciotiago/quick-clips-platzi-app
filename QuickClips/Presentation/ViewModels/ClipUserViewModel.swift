//
//  ClipUserViewModel.swift
//  QuickClips
//
//  Created by Santiago Moreno on 29/06/24.
//

import Foundation

struct ClipUserViewModel {
    
    private let userClip: UserClip
    
    init(userClip: UserClip) {
        self.userClip = userClip
    }
    
    var name: String {
        return self.userClip.name
    }
    
    var profileUrl: URL? {
        return URL(string: self.userClip.profileUrl)
    }
    
    var profileImageUrl: String {
        let replacedName = self.name.replacingOccurrences(of: " ", with: "+")
        return "https://ui-avatars.com/api/?name= \(replacedName)"
    }
}
