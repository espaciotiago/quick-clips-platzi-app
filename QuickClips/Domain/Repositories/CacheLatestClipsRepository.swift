//
//  CacheLatestClipsRepository.swift
//  QuickClips
//
//  Created by Santiago Moreno on 30/06/24.
//

import Foundation

protocol CacheLatestClipsRepository {
    func cacheLatestClips(_ clips: [Clip])
}
