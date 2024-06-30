//
//  GetClipsUseCase.swift
//  QuickClips
//
//  Created by Santiago Moreno on 30/06/24.
//

import Foundation

protocol GetClipsUseCaseProtocol {
    func execute(page: Int, limit: Int) async throws -> Result<[Clip], Error>
}

struct GetClipsUseCase: GetClipsUseCaseProtocol {
    
    let remoteDataSource: GetClipsRepository
    
    let localDataSource: GetClipsRepository
    
    let networkMonitor: CheckConnectionProtocol
    
    func execute(page: Int, limit: Int) async throws -> Result<[Clip], Error> {
        do {
            let hasConnection = await self.networkMonitor.checkConnection()
            var result: Result<[Clip], Error>
            if(hasConnection) {
                result = try await self.remoteDataSource.getClips(page: page, limit: limit)
            } else {
                result = try await self.localDataSource.getClips(page: page, limit: limit)
            }
            switch result {
            case .success(let clips):
                return .success(clips)
            case .failure(let remoteError):
                return .failure(remoteError)
            }
        } catch {
            return .failure(error)
        }
    }
}
