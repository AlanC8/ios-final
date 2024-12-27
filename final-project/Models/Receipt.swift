//
//  Receipt.swift
//  final-project
//
//  Created by Алан Абзалханулы on 26.12.2024.
//

import Foundation
// https://reciepts-back-production.up.railway.app/reciepts
struct Receipt: Codable {
    let id: Int
    let image: [String]
    let title: String
    let description: String
    let price: Double
    let category: String
    let rating: Double
    let ingredients: [String]
    let calories: Int
    let preparationTime: Int
}
