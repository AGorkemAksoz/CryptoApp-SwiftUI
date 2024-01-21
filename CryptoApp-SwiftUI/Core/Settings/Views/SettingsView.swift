//
//  SettingsView.swift
//  CryptoApp-SwiftUI
//
//  Created by Ali Görkem Aksöz on 21.01.2024.
//

import SwiftUI

struct SettingsView: View {
    
    let coinGeckoURL = URL(string: "https://www.coingecko.com")!
    let developerGithubURL = URL(string: "https://github.com/AGorkemAksoz")!
    
    var body: some View {
        NavigationView {
            List {
                coinGeckoSection
                developerSection
            }
            .listStyle(.grouped)
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton()
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}


extension SettingsView {
    private var coinGeckoSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("The cryptocureency data that is used in this app comes from a free API from CoinGecko! Prices may be slightly delayed.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(.theme.accent)
            }
            .padding(.vertical)
            
            Link("Visit CoinGecko 🥳", destination: coinGeckoURL)
        } header: {
            Text("CoinGecko")
        }
    }
    
    private var developerSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was developed by Ali Görkem Aksöz. It uses SwiftUI and is written 100% in Swift. The project benefits from multi-thearding, publishers/subscribers, and data persistance.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(.theme.accent)
            }
            .padding(.vertical)
            
            Link("Visit My Github 🥳", destination: developerGithubURL)
        } header: {
            Text("Developer")
        }

    }
}
