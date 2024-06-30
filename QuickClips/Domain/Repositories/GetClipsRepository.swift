//
//  GetClipsRepository.swift
//  QuickClips
//
//  Created by Santiago Moreno on 30/06/24.
//

import Foundation

protocol GetClipsRepository {
    func getClips(page: Int, limit: Int) async throws -> Result<[Clip], Error>
}
