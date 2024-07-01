//
//  CacheLatestClipsRepository.swift
//  QuickClips
//
//  Created by Santiago Moreno on 30/06/24.
//

import Foundation

typealias CacheLatestClipsCompletion = (_ completed: Bool) -> Void

protocol CacheLatestClipsRepository {
    func cacheLatestClips(_ clips: [Clip], completion: @escaping CacheLatestClipsCompletion)
}
