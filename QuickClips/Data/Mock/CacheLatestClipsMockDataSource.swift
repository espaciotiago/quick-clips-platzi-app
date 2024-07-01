//
//  CacheLatestClipsMockDataSource.swift
//  QuickClips
//
//  Created by Santiago Moreno on 30/06/24.
//

import Foundation

struct CacheLatestClipsMockDataSource: CacheLatestClipsRepository {
    
    func cacheLatestClips(_ clips: [Clip], completion: @escaping CacheLatestClipsCompletion) {
        completion(true)
    }
}
