//
//  CacheLatestClipsUseCase.swift
//  QuickClips
//
//  Created by Santiago Moreno on 30/06/24.
//

import Foundation

protocol CacheLatestClipsProtocol {
    func execute(_ clips: [Clip], completion: @escaping CacheLatestClipsCompletion)
}

struct CacheLatestClipsUseCase: CacheLatestClipsProtocol {
    
    let localCacheLatestClipsDataSource: CacheLatestClipsRepository
    
    func execute(_ clips: [Clip], completion: @escaping CacheLatestClipsCompletion) {
        self.localCacheLatestClipsDataSource.cacheLatestClips(clips, completion: completion)
    }
}
