//
//  CryptoApp_SwiftUIApp.swift
//  CryptoApp-SwiftUI
//
//  Created by Gorkem on 16.01.2024.
//

import SwiftUI

@main
struct CryptoApp_SwiftUIApp: App {
    
    @StateObject private var vm = HomeViewModel()
    @State private var showLauncView: Bool = true
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationView {
                    HomeView()
                        .navigationBarHidden(true)
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .environmentObject(vm)
                
                ZStack {
                    if showLauncView {
                        LaunchView(showLauncView: $showLauncView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
            }
        }
    }
}
