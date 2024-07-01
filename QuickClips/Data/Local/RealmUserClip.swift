//
//  RealmUserClip.swift
//  QuickClips
//
//  Created by Santiago Moreno on 30/06/24.
//

import Foundation
import RealmSwift

class RealmUserClip: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var userId: Int
    @Persisted var name: String
    @Persisted var profileUrl: String
    
    convenience init(userId: Int, name: String, profileUrl: String) {
        self.init()
        self.userId = userId
        self.name = name
        self.profileUrl = profileUrl
    }
}

extension RealmUserClip {
    func toUserClip() -> UserClip {
        return UserClip(id: self.userId,
                        name: self.name,
                        profileUrl: self.profileUrl)
    }
}
