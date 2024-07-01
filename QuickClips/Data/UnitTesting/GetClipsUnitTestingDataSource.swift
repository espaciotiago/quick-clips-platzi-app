//
//  GetClipsUnitTestingDataSource.swift
//  QuickClips
//
//  Created by Tiago on 1/07/24.
//

import Foundation

struct GetClipsUnitTestingDataSource: GetClipsRepository {
    
    let isRemote: Bool
    let error: Error?
    let feed: [Clip]?
    
    init(isRemote: Bool = true,
         error: Error? = nil,
         feed: [Clip]? = nil) {
        self.isRemote = isRemote
        self.error = error
        self.feed = feed
    }
    
    func getClips(page: Int, limit: Int) async throws -> Result<GetClipsSuccessResult, Error> {
        if let error = self.error {
            return .failure(error)
        } else if let feed = self.feed {
            return .success((clips: feed, shouldCacheClips: true))
        } else {
            let imageUrl = isRemote ? "https://images.pexels.com/videos/1526909/free-video-1526909.jpg?auto=compress&cs=tinysrgb&fit=crop&h=630&w=1200" : "https://images.pexels.com/videos/2098989/free-video-2098989.jpg?auto=compress&cs=tinysrgb&fit=crop&h=630&w=1200"
            let userName = "\(isRemote ? "Remote" : "Local") Doe"
            var feedAux = [Clip]()
            for i in 0..<limit {
                let clip = Clip(id: i,
                                imageUrl: imageUrl,
                                videoUrl: "https://videos.pexels.com/video-files/1526909/1526909-hd_1280_720_24fps.mp4",
                                user: UserClip(id: 1,
                                               name: userName,
                                               profileUrl: "https://www.pexels.com/@digitech"))
                feedAux.append(clip)
            }
            return .success((clips: feedAux, shouldCacheClips: self.isRemote))
        }
    }
}
