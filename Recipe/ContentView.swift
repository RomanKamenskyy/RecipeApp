//
//  ContentView.swift
//  Recipe
//
//  Created by roman on 22.11.2024.
//

import SwiftUI

struct ContentView: View {
   
    var body: some View {
       
    
            TabView {
                RecipeListView()
           
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("Recipes")
                    }
                FavoritesView()
                    .tabItem {
                        Image(systemName: "star.fill")
                        Text("Favorites")
                    }
            
        }
    }
}

#Preview {
    ContentView()
}



