//
//  RecipeRowView.swift
//  Recipe
//
//  Created by roman on 22.11.2024.
//
import SwiftUI

struct RecipeRowView: View {
    let recipe: Recipe
    
    var body: some View {
        
        HStack {
            
            // Изображение рецепта
            if let imageUrl = recipe.image, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 80, height: 80)
                .cornerRadius(8)
            } else {
                // Плейсхолдер, если изображения нет
                Rectangle()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 80, height: 80)
                    .cornerRadius(8)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                // Название рецепта
                Text(recipe.title)
                    .font(.headline)
                
                // Время приготовления
                if let readyInMinutes = recipe.readyInMinutes {
                    Text("\(readyInMinutes) minutes")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            Spacer()
        }
        .padding(.vertical, 5)
    }
    
}
