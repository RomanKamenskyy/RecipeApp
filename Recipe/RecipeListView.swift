//
//  RecipeListView.swift
//  Recipe
//
//  Created by roman on 22.11.2024.
//

import SwiftUI

struct RecipeListView: View {
    @State private var recipes: [Recipe] = []
    @State private var searchText: String = ""
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    let api = RecipeAPI()
    
    func loadRecipes() {
        guard !searchText.isEmpty else { return }
        
        isLoading = true
        errorMessage = nil
        
        api.fetchRecipes(query: searchText) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let recipes):
                    self.recipes = recipes
                case .failure(let error):
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            
            HStack {
                VStack {
                    SearchBarView(text: $searchText, onSearch: loadRecipes)
                    if isLoading {
                        ProgressView("Loading...")
                    } else if let errorMessage = errorMessage {
                        Text("Error: \(errorMessage)")
                            .foregroundColor(.red)
                    } else {
                        List(recipes) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipeID: recipe.id)) {
                                RecipeRowView(recipe: recipe)
                            }
                        }
                    }
                }
                
                .navigationTitle("Recipes")
                
            }
        }
        
    }
}

#Preview {
    RecipeListView()
}
