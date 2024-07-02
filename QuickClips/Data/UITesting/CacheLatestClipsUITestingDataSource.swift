//
//  CacheLatestClipsUITestingDataSource.swift
//  QuickClips
//
//  Created by Santiago Moreno on 1/07/24.
//

import Foundation

struct CacheLatestClipsUITestingDataSource: CacheLatestClipsRepository {
    
    func cacheLatestClips(_ clips: [Clip], completion: @escaping CacheLatestClipsCompletion) {
        completion(true)
    }
}
