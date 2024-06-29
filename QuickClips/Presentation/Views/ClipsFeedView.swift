//
//  ClipsFeedView.swift
//  QuickClips
//
//  Created by Santiago Moreno on 29/06/24.
//

import SwiftUI

struct ClipsFeedView: View {
    
    @State private var isDetailViewActive = false
    
    var body: some View {
        ZStack {
            Color(.primary).edgesIgnoringSafeArea(.all)
            ScrollView {
                LazyVStack(spacing: 32) {
                    ClipCardView(clipSelected: {
                        self.isDetailViewActive = true
                    }, profileSelected: {})
                    ClipCardView(clipSelected: {
                        self.isDetailViewActive = true
                    }, profileSelected: {})
                    ClipCardView(clipSelected: {
                        self.isDetailViewActive = true
                    }, profileSelected: {})
                    ClipCardView(clipSelected: {
                        self.isDetailViewActive = true
                    }, profileSelected: {})
                }.padding()
            }
        }
        .navigationTitle("QuickClips")
        .navigationDestination(isPresented: self.$isDetailViewActive) {
            ClipDetailView()
        }
    }
}

#Preview {
    ClipsFeedView()
}
