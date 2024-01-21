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
    
    @StateObject private var vm: CoinDetailViewModel
    @State private var showFullDescription: Bool = false
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    private let spacing: CGFloat = 30
    
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        _vm = StateObject(wrappedValue: CoinDetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ChartView(coin: coin)
                    .padding(.vertical)
                VStack(spacing: 20) {
                    ovewviewTitle
                    Divider()
                    descriptionSection
                    
                    overviewLazyGrid
                    
                    additionalViewTitle
                    Divider()
                    additionalLazyGrid
                    
                    websitesSection
                    
                }
                .padding()
            }
        }
        .navigationTitle(coin.name!)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarTrailingItem
            }
        }
    }
}

struct DetailView_Preivews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin)
        }
    }
}


extension DetailView {
    private var ovewviewTitle: some View {
        Text("Overview")
            .font(.title.bold())
            .foregroundColor(.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var descriptionSection: some View {
        ZStack {
            if let coinDescription = vm.coinDescription,
               !coinDescription.isEmpty {
                VStack(alignment: .leading) {
                    Text(coinDescription)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                        .foregroundColor(.theme.secondaryText)
                    
                    Button {
                        withAnimation(.easeInOut) {
                            showFullDescription.toggle()
                        }
                    } label: {
                        Text(showFullDescription ? "Less" : "Read more...")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.vertical, 4)
                    }
                    .accentColor(.blue)

                }
            }
        }
    }
    
    private var websitesSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let webString = vm.websiteURL,
               let url = URL(string: webString) {
                Link("Website", destination: url)
            }
            
            if let redditString = vm.redditURL,
               let url = URL(string: redditString) {
                Link("Reddit", destination: url)
            }
        }
        .accentColor(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline)
    }
    
    private var additionalViewTitle: some View {
        Text("Additional Details")
            .font(.title.bold())
            .foregroundColor(.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var overviewLazyGrid: some View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing) {
            ForEach(vm.overviewStatistics) { stat in
                StatisticView(stat: stat)
            }
        }
    }
    
    private var additionalLazyGrid: some View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing) {
            ForEach(vm.additionalStatistics) { stat in
                StatisticView(stat: stat)
            }
        }
    }
    
    private var navigationBarTrailingItem: some View {
        HStack {
            Text(coin.name!)
                .font(.headline)
                .foregroundColor(.theme.secondaryText)
            CoinImageView(coin: coin)
                .frame(width: 25, height: 25)
        }
    }
}
