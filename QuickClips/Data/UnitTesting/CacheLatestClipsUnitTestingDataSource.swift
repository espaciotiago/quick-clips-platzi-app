//
//  CacheLatestClipsUnitTestingDataSource.swift
//  QuickClips
//
//  Created by Santiago Moreno on 1/07/24.
//

import Foundation

struct CacheLatestClipsUnitTestingDataSource: CacheLatestClipsRepository {
    
    private let cacheCompleted: Bool
    
    init(cacheCompleted: Bool = true) {
        self.cacheCompleted = cacheCompleted
    }
    
    func cacheLatestClips(_ clips: [Clip], completion: @escaping CacheLatestClipsCompletion) {
        completion(self.cacheCompleted)
    }
}
