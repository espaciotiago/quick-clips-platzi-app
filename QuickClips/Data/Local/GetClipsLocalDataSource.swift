//
//  GetClipsLocalDataSource.swift
//  QuickClips
//
//  Created by Santiago Moreno on 30/06/24.
//

import Foundation
import RealmSwift

struct GetClipsLocalDataSource: GetClipsRepository {
    
    func getClips(page: Int, limit: Int) async throws -> Result<[Clip], Error> {
        let clips = try await self.getClipsAsync()
        return .success(clips)
    }
    func getClipsAsync() async throws -> [Clip] {
        return try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.global().async {
                do {
                    let realm = try Realm()
                    let realmClips = realm.objects(RealmClip.self)
                    var clips = [Clip]()
                    
                    for realmClip in realmClips {
                        if let clip = realmClip.toClip() {
                            clips.append(clip)
                        }
                    }
                    continuation.resume(returning: clips)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
