//
//  FavoritesManager.swift
//  final-project
//
//  Created by Алан Абзалханулы on 26.12.2024.
//

import UIKit

class FavoritesManager {
    static let shared = FavoritesManager()
    private let defaults = UserDefaults.standard
    private let favoritesKey = "favoriteReceipts"
    
    func saveToFavorites(_ receipt: Receipt) {
        var favorites = getFavorites()
        favorites.append(receipt)
        
        if let encoded = try? JSONEncoder().encode(favorites) {
            defaults.set(encoded, forKey: favoritesKey)
        }
    }
    
    func removeFromFavorites(_ receipt: Receipt) {
        var favorites = getFavorites()
        favorites.removeAll { $0.id == receipt.id }
        
        if let encoded = try? JSONEncoder().encode(favorites) {
            defaults.set(encoded, forKey: favoritesKey)
        }
    }
    
    func getFavorites() -> [Receipt] {
        guard let data = defaults.data(forKey: favoritesKey),
              let favorites = try? JSONDecoder().decode([Receipt].self, from: data) else {
            return []
        }
        return favorites
    }
    
    func isInFavorites(_ receipt: Receipt) -> Bool {
        let favorites = getFavorites()
        return favorites.contains { $0.id == receipt.id }
    }
}
