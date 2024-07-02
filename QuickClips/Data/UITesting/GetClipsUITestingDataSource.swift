//
//  GetClipsUITestingDataSource.swift
//  QuickClips
//
//  Created by Santiago Moreno on 1/07/24.
//

import Foundation

struct GetClipsUITestingDataSource: GetClipsRepository {
    
    let isRemote: Bool
    
    init(isRemote: Bool = true) {
        self.isRemote = isRemote
    }
    
    func getClips(page: Int, limit: Int) async throws -> Result<GetClipsSuccessResult, Error> {
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
