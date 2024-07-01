//
//  CacheLatestClipsUseCase.swift
//  QuickClips
//
//  Created by Santiago Moreno on 30/06/24.
//

import Foundation

protocol CacheLatestClipsProtocol {
    func execute(_ clips: [Clip])
}

struct CacheLatestClipsUseCase: CacheLatestClipsProtocol {
    
    let localCacheLatestClipsDataSource: CacheLatestClipsRepository
    
    func execute(_ clips: [Clip]) {
        self.localCacheLatestClipsDataSource.cacheLatestClips(clips)
    }
}
