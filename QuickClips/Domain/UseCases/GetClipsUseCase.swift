//
//  GetClipsUseCase.swift
//  QuickClips
//
//  Created by Santiago Moreno on 30/06/24.
//

import Foundation

protocol GetClipsUseCaseProtocol {
    func execute(page: Int, limit: Int) async throws -> Result<GetClipsSuccessResult, Error>
}

struct GetClipsUseCase: GetClipsUseCaseProtocol {
    
    let remoteDataSource: GetClipsRepository
    
    let localDataSource: GetClipsRepository
    
    let networkMonitor: CheckConnectionProtocol
    
    func execute(page: Int, limit: Int) async throws -> Result<GetClipsSuccessResult, Error> {
        do {
            let hasConnection = await self.networkMonitor.checkConnection()
            var result: Result<GetClipsSuccessResult, Error>
            if(hasConnection) {
                result = try await self.remoteDataSource.getClips(page: page, limit: limit)
            } else {
                result = try await self.localDataSource.getClips(page: page, limit: limit)
            }
            switch result {
            case .success(let result):
                return .success(result)
            case .failure(let error):
                return .failure(error)
            }
        } catch {
            return .failure(error)
        }
    }
}
