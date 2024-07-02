//
//  AppCompositionRoot.swift
//  QuickClips
//
//  Created by Santiago Moreno on 30/06/24.
//

import Foundation

struct AppCompositionRoot {
    
    static var shared = AppCompositionRoot()
    
    let getClipsUseCase: GetClipsUseCaseProtocol
    
    let cacheLatestClipsUseCase: CacheLatestClipsUseCase
    
    init() {
        let factory = UseCasesFactory()
        self.getClipsUseCase = factory.getClipsUseCase
        self.cacheLatestClipsUseCase = factory.cacheLatestClipsUseCase
    }
}
