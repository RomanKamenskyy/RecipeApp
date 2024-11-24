//
//  Recipe.swift
//  Recipe
//
//  Created by roman on 22.11.2024.
//

import Foundation

struct Recipe: Identifiable, Codable {
    let id: Int
    let title: String
    let image: String?
    let readyInMinutes: Int?
    let servings: Int?

    enum CodingKeys: String, CodingKey {
        case id, title, image, readyInMinutes, servings
    }
}
