//
//  ClipsFeedView.swift
//  QuickClips
//
//  Created by Santiago Moreno on 29/06/24.
//

import SwiftUI

struct ClipsFeedView: View {
    var body: some View {
        ZStack {
            Color(.primary).edgesIgnoringSafeArea(.all)
            ScrollView {
                LazyVStack(spacing: 32) {
                    ClipCardView(clipSelected: {}, profileSelected: {})
                    ClipCardView(clipSelected: {}, profileSelected: {})
                    ClipCardView(clipSelected: {}, profileSelected: {})
                    ClipCardView(clipSelected: {}, profileSelected: {})
                }.padding()
            }
        }.navigationTitle("QuickClips")
    }
}

#Preview {
    ClipsFeedView()
}
