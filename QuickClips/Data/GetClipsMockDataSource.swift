//
//  GetClipsMockDataSource.swift
//  QuickClips
//
//  Created by Santiago Moreno on 30/06/24.
//

import Foundation

struct GetClipsMockDataSource: GetClipsRepository {
    
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
    
    func getClips(page: Int, limit: Int) async throws -> Result<[Clip], Error> {
        if let error = self.error {
            return .failure(error)
        } else if let feed = self.feed {
            return .success(feed)
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
            return .success(feedAux)
        }
    }
}
