//
//  LaunchView.swift
//  CryptoApp-SwiftUI
//
//  Created by Ali Görkem Aksöz on 21.01.2024.
//

import SwiftUI

struct LaunchView: View {
    
    @State private var loadingText: [String] = "Loading your portfolio...".map({String($0)})
    @State private var showLoadingText: Bool = false
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    @State private var counter: Int = 0
    @State private var loop: Int = 0
    @Binding var showLauncView: Bool
    
    var body: some View {
        ZStack {
            Color.launchTheme.background
                .ignoresSafeArea()
            
            
            Image("logo-transparent")
                .resizable()
                .frame(width: 100, height: 100)
            
            ZStack {
                if showLoadingText {
                    HStack(spacing: 0) {
                        ForEach(loadingText.indices) { index in
                            Text(loadingText[index])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundColor(.launchTheme.accent)
                                .offset(y: counter == index ? -5 : 0)
                        }
                    }
                    .transition(AnyTransition.scale.animation(.easeIn))
                }
            }
            .offset(y: 70)
        }
        .onAppear {
            showLoadingText.toggle()
        }
        .onReceive(timer) { _ in
            withAnimation(.spring()) {
                
                let lastIndex = loadingText.count - 1
                
                if counter == lastIndex {
                    counter = 0
                    loop += 1
                    
                    if loop >= 2 {
                        showLauncView = false
                    }
                } else {
                    counter += 1
                }
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLauncView: .constant(true))
    }
}
