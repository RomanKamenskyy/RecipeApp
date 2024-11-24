//
//  RecipeDetail.swift
//  Recipe
//
//  Created by roman on 22.11.2024.
//

import Foundation

struct RecipeDetail: Codable {
    let id: Int
    let title: String
    let image: String?
    let readyInMinutes: Int?
    let servings: Int?
    let instructions: String?
    let extendedIngredients: [Ingredient]

    struct Ingredient: Codable {
        let id: Int
        let name: String
        let amount: Double
        let unit: String
    }
}
