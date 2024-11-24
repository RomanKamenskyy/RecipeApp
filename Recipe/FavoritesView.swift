//
//  FavoritesView.swift
//  Recipe
//
//  Created by roman on 22.11.2024.
//

import SwiftUI
import CoreData

struct FavoritesView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: FavoriteRecipe.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \FavoriteRecipe.title, ascending: true)]
    ) var favoriteRecipes: FetchedResults<FavoriteRecipe>

    var body: some View {
        NavigationView {
            List {
                ForEach(favoriteRecipes) { favorite in
                    NavigationLink(destination: RecipeDetailView(recipeID: Int(favorite.id!) ?? 0)) {
                        HStack {
                            if let imageURL = favorite.imageURL, let url = URL(string: imageURL) {
                                AsyncImage(url: url) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(8)
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                            Text(favorite.title ?? "Untitled")
                        }
                    }
                }
                .onDelete(perform: deleteFavorite)
            }
            .navigationTitle("Favorites")
            .toolbar {
                EditButton()
            }
        }
    }

    private func deleteFavorite(at offsets: IndexSet) {
        for index in offsets {
            let favorite = favoriteRecipes[index]
            viewContext.delete(favorite)
        }

        do {
            try viewContext.save()
        } catch {
            print("Error deleting favorite: \(error.localizedDescription)")
        }
    }
}
#Preview {
    FavoritesView()
}
