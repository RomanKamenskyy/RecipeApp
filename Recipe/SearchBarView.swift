//
//  SearchBarView.swift
//  Recipe
//
//  Created by roman on 22.11.2024.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    var onSearch: () -> Void

    var body: some View {
        HStack {
            TextField("Search recipes...", text: $text, onCommit: onSearch)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)

            Button(action: onSearch) {
                Image(systemName: "magnifyingglass")
                    .padding(8)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Circle())
            }
        }
        .padding(.vertical, 5)
    }
}
