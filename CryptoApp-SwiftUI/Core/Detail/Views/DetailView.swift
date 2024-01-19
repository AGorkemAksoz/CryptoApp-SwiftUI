//
//  DetailView.swift
//  CryptoApp-SwiftUI
//
//  Created by Gorkem on 19.01.2024.
//

import SwiftUI

struct DetailLoadingView: View{
    @Binding var coin: CoinModel?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
 
}

struct DetailView: View {
    
    @StateObject var vm: CoinDetailViewModel
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        _vm = StateObject(wrappedValue: CoinDetailViewModel(coin: coin))
    }
    
    var body: some View {
        Text(coin.name ?? "")
    }
}

struct DetailView_Preivews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coin)
    }
}
