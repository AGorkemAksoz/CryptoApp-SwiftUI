//
//  CryptoApp_SwiftUIApp.swift
//  CryptoApp-SwiftUI
//
//  Created by Gorkem on 16.01.2024.
//

import SwiftUI

@main
struct CryptoApp_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
        }
    }
}
