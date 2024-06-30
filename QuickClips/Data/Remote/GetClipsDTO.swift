//
//  GetClipsDTO.swift
//  QuickClips
//
//  Created by Santiago Moreno on 30/06/24.
//

import Foundation

struct GetClipsDTO {
    
    let json: [String : Any]?
    
    init(_ json: [String : Any]?) {
        self.json = json
    }
    
    func getFeed() throws -> [Clip] {
        guard let json = self.json else {
            throw NSError(domain: "Invalid data", code: 0, userInfo: nil)
        }
        return []
    }
}
