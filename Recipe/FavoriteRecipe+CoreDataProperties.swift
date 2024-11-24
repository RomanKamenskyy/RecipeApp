//
//  FavoriteRecipe+CoreDataProperties.swift
//  Recipe
//
//  Created by roman on 22.11.2024.
//
//

import Foundation
import CoreData


extension FavoriteRecipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteRecipe> {
        return NSFetchRequest<FavoriteRecipe>(entityName: "FavoriteRecipe")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var imageURL: String?

}

extension FavoriteRecipe : Identifiable {

}
