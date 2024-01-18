//
//  PortfolioDataService.swift
//  CryptoApp-SwiftUI
//
//  Created by Gorkem on 18.01.2024.
//

import CoreData
import Foundation

class PortfolioDataService {
    
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { [weak self] _, error in
            if let error = error {
                print("Error loading Core Data! \(error)")
            }
            self?.getPortfolio()
        }
    }
    
    // MARK: - PUBLIC SECTION
    
    func updatePortfolio(to coin: CoinModel, amount: Double) {
        
        if let entity = savedEntities.first(where: {$0.coinID == coin.id}) {
            if amount > 0 {
                update(to: entity, amount: amount)
            } else {
                delete(to: entity)
            }
        } else {
            add(to: coin, amount: amount)
        }
        
    }
    
    //MARK: - PRIVATE SECTION
    
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching portfolio entities. \(error)")
        }
    }
    
    private func add(to coin: CoinModel, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func update(to entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(to entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to core data. \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
}
