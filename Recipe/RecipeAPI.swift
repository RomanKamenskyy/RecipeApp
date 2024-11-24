//
//  RecipeAPI.swift
//  Recipe
//
//  Created by roman on 22.11.2024.
//

import Foundation

class RecipeAPI {
    private let apiKey = "input your api key here"
    private let baseURL = "https://api.spoonacular.com"

    func fetchRecipes(query: String, completion: @escaping (Result<[Recipe], Error>) -> Void) {
        let urlString = "\(baseURL)/recipes/complexSearch?query=\(query)&apiKey=\(apiKey)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 500, userInfo: nil)))
                return
            }

            do {
                let result = try JSONDecoder().decode(RecipeResponse.self, from: data)
                completion(.success(result.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchRecipeDetails(id: Int, completion: @escaping (Result<RecipeDetail, Error>) -> Void) {
        let urlString = "\(baseURL)/recipes/\(id)/information?apiKey=\(apiKey)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 500, userInfo: nil)))
                return
            }

            do {
                let recipeDetail = try JSONDecoder().decode(RecipeDetail.self, from: data)
                completion(.success(recipeDetail))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

// Вспомогательная структура для обработки списка рецептов
struct RecipeResponse: Codable {
    let results: [Recipe]
}
