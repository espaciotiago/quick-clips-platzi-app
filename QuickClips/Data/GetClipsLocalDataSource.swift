//
//  GetClipsLocalDataSource.swift
//  QuickClips
//
//  Created by Santiago Moreno on 30/06/24.
//

import Foundation

struct GetClipsLocalDataSource: GetClipsRepository {
    
    func getClips(page: Int, limit: Int) async throws -> Result<[Clip], Error> {
        var feedAux = [Clip]()
        for i in 0..<5 {
            let clip = Clip(id: i,
                            imageUrl: "https://images.pexels.com/videos/1526909/free-video-1526909.jpg?auto=compress&cs=tinysrgb&fit=crop&h=630&w=1200",
                            videoUrl: "https://videos.pexels.com/video-files/1526909/1526909-hd_1280_720_24fps.mp4",
                            user: UserClip(id: 1,
                                           name: "Jhon Doe",
                                           profileUrl: "https://www.pexels.com/@digitech"))
            feedAux.append(clip)
        }
        return .success(feedAux)
    }
}
