//
//  QuickClipsApp.swift
//  QuickClips
//
//  Created by Santiago Moreno on 29/06/24.
//

import SwiftUI

@main
struct QuickClipsApp: App {
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "font") ?? UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "font") ?? UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
