//
//  GetClipsDTO.swift
//  QuickClips
//
//  Created by Santiago Moreno on 30/06/24.
//

import Foundation

private struct ClipUserDTO: JsonParserProtocol {
    
    static let idKey = "id"
    static let nameKey = "name"
    static let urlKey = "url"
    
    let json: [String : Any]?
    
    init(_ json: [String : Any]?) {
        self.json = json
    }
    
    func getUserClip()  throws -> UserClip {
        guard let json = self.json,
              let id = json[ClipUserDTO.idKey] as? Int,
              let name = json[ClipUserDTO.nameKey] as? String,
              let url = json[ClipUserDTO.urlKey] as? String else {
            throw NSError(domain: "Invalid data", code: 0, userInfo: nil)
        }
        return UserClip(id: id,
                        name: name,
                        profileUrl: url)
    }
}

private struct ClipDTO: JsonParserProtocol {
    
    static let idKey = "id"
    static let imageKey = "image"
    static let videoFilesKey = "video_files"
    static let linkKey = "link"
    static let userKey = "user"
    
    let json: [String : Any]?
    
    init(_ json: [String : Any]?) {
        self.json = json
    }
    
    func getClip()  throws -> Clip {
        guard let json = self.json,
              let id = json[ClipDTO.idKey] as? Int,
              let videoFiles = json[ClipDTO.videoFilesKey] as? [[String: Any]],
              let firstVideoFiles = videoFiles.first else {
            throw NSError(domain: "Invalid data", code: 0, userInfo: nil)
        }
        do {
            let imageUrl = json[ClipDTO.imageKey] as? String ?? ""
            let videoUrl = firstVideoFiles[ClipDTO.linkKey] as? String ?? ""
            let userJson = json[ClipDTO.userKey] as? [String: Any]
            let user = try ClipUserDTO(userJson).getUserClip()
            
            return Clip(id: id,
                        imageUrl: imageUrl,
                        videoUrl: videoUrl,
                        user: user)
        } catch {
            throw NSError(domain: "Invalid data", code: 0, userInfo: nil)
        }
    }
}

struct GetClipsDTO: JsonParserProtocol {
    
    static let videosKey = "videos"
    
    let json: [String : Any]?
    
    init(_ json: [String : Any]?) {
        self.json = json
    }
    
    func getFeed() throws -> [Clip] {
        guard let json = self.json,
              let videosList = json[GetClipsDTO.videosKey] as? [[String: Any]] else {
            throw NSError(domain: "Invalid data", code: 0, userInfo: nil)
        }
        do {
            return try videosList.map { jsonObj in
                return try ClipDTO(jsonObj).getClip()
            }
        } catch {
            throw NSError(domain: "Invalid data", code: 0, userInfo: nil)
        }
    }
}
