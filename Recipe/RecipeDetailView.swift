//
//  RecipeDetailView.swift
//  Recipe
//
//  Created by roman on 22.11.2024.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipeID: Int
    @Environment(\.managedObjectContext) private var viewContext

    @State private var recipeDetail: RecipeDetail?
    @State private var isLoading = false
    @State private var errorMessage: String?

    let api = RecipeAPI()

    func loadRecipeDetails() {
        isLoading = true
        errorMessage = nil

        api.fetchRecipeDetails(id: recipeID) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let detail):
                    self.recipeDetail = detail
                case .failure(let error):
                    errorMessage = error.localizedDescription
                }
            }
        }
    }

    func addToFavorites() {
        guard let recipe = recipeDetail else { return }

        let favorite = FavoriteRecipe(context: viewContext)
        favorite.id = String(recipe.id)
        favorite.title = recipe.title
        favorite.imageURL = recipe.image

        do {
            try viewContext.save()
        } catch {
            print("Error saving favorite: \(error)")
        }
    }

    var body: some View {
        ScrollView {
            if isLoading {
                ProgressView("Loading...")
            } else if let errorMessage = errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
            } else if let recipe = recipeDetail {
                VStack(alignment: .leading, spacing: 20) {
                    if let imageUrl = recipe.image {
                        AsyncImage(url: URL(string: imageUrl)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 200)
                        .cornerRadius(8)
                    }

                    Text(recipe.title)
                        .font(.largeTitle)
                        .bold()

                    if let readyInMinutes = recipe.readyInMinutes {
                        Text("Ready in \(readyInMinutes) minutes")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }

                    Text("Ingredients")
                        .font(.headline)

                    ForEach(recipe.extendedIngredients, id: \.id) { ingredient in
                        Text("• \(ingredient.amount, specifier: "%.1f") \(ingredient.unit) \(ingredient.name)")
                    }

                    if let instructions = recipe.instructions {
                        Text("Instructions")
                            .font(.headline)
                        Text(instructions)
                    }

                    Button(action: addToFavorites) {
                        Text("Add to Favorites")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Recipe Details")
        .onAppear(perform: loadRecipeDetails)
    }
}
