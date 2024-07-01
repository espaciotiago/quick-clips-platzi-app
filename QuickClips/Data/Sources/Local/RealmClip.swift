//
//  RealmClip.swift
//  QuickClips
//
//  Created by Santiago Moreno on 30/06/24.
//

import Foundation
import RealmSwift

class RealmClip: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var clipId: Int
    @Persisted var imageUrl: String
    @Persisted var videoUrl: String
    @Persisted var user: RealmUserClip?
    
    convenience init(clipId: Int, imageUrl: String, videoUrl: String, user: RealmUserClip?) {
        self.init()
        self.clipId = clipId
        self.imageUrl = imageUrl
        self.videoUrl = videoUrl
        self.user = user
    }
}

extension RealmClip {
    func toClip() -> Clip? {
        guard let user = self.user?.toUserClip() else {
            return nil
        }
        return Clip(id: self.clipId,
                    imageUrl: self.imageUrl,
                    videoUrl: self.videoUrl,
                    user: user)
    }
}
