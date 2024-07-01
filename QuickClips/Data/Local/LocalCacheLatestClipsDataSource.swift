//
//  LocalCacheLatestClipsDataSource.swift
//  QuickClips
//
//  Created by Santiago Moreno on 30/06/24.
//

import Foundation
import RealmSwift

struct LocalCacheLatestClipsDataSource: CacheLatestClipsRepository {
    
    func cacheLatestClips(_ clips: [Clip]) {
        DispatchQueue.main.async {
            let realm = try! Realm()
            let savedRealmClips = realm.objects(RealmClip.self)
            
            let realmClips = clips.map {
                let userClip = $0.user
                let realmUserClip = RealmUserClip(userId: userClip.id, name: userClip.name, profileUrl: userClip.profileUrl)
                return RealmClip(clipId: $0.id, imageUrl: $0.imageUrl, videoUrl: $0.videoUrl, user: realmUserClip)
            }
            try! realm.write {
                realm.delete(savedRealmClips)
                realm.add(realmClips)
            }
        }
    }
}
