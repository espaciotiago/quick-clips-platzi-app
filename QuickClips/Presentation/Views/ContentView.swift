//
//  ContentView.swift
//  QuickClips
//
//  Created by Santiago Moreno on 29/06/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ClipsFeedView(viewModel: ClipsFeedViewModel(getClipsUseCase: GetClipsUseCase(remoteDataSource: GetClipsRemoteDataSource(),
                                                                                         localDataSource: GetClipsLocalDataSource(),
                                                                                         networkMonitor: NetworkMonitor())))
        }
    }
}

#Preview {
    ContentView()
}
