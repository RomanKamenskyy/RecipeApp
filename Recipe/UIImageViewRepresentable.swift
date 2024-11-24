//
//  UIImageViewRepresentable.swift
//  Recipe
//
//  Created by roman on 23.11.2024.
//
import SwiftUI
import UIKit

struct UIImageViewRepresentable: UIViewRepresentable {
    let imageName: String

    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill // Подгонка изображения
        imageView.clipsToBounds = true // Обрезает края, если изображение выходит за границы
        return imageView
    }

    func updateUIView(_ uiView: UIImageView, context: Context) {
        uiView.image = UIImage(named: imageName)
    }
}
