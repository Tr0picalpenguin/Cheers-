//
//  CustomCocktail.swift
//  Cheers!
//
//  Created by Scott Cox on 7/11/22.
//

import Foundation

class CustomCocktail {
    
        enum CocktailKeys {
            static let cocktailName = "name"
            static let glass = "glass"
            static let instruction = "instruction"
            static let uuid = "uuid"
            static let collectionType = "cocktails"
            static let imageURL = "imageURL"
            static let ingredients = "ingredients"
           static let numberOfLikes = "numberOfLikes"

        }
        // MARK: - Properties
    var numberOfLikes: Int
    var cocktailName: String
    var glass: String?
    var instruction: String
    var uuid: String
    var imageURL: String?
    var ingredients: [CustomIngredient]
    

        // Dictionary representation
        var cocktailData: [String: Any] {
            [CocktailKeys.cocktailName: self.cocktailName,
             CocktailKeys.numberOfLikes: self.numberOfLikes,
             CocktailKeys.glass: self.glass as Any,
             CocktailKeys.instruction: self.instruction,
             CocktailKeys.uuid: self.uuid,
             CocktailKeys.imageURL: self.imageURL as Any,
             CocktailKeys.ingredients: self.ingredients.map {$0.ingredientData}]
        }

        // MARK: - Initializers
    init(numberOfLikes: Int, cocktailName: String, glass:String, instruction: String, uuid: String = UUID().uuidString, ingredients: [CustomIngredient], imageURL: String) {
            
        self.numberOfLikes = numberOfLikes
            self.cocktailName = cocktailName
            self.instruction = instruction
            self.glass = glass
            self.uuid = uuid
            self.imageURL = imageURL
            self.ingredients = ingredients
        }
} // end of class


extension CustomCocktail {

    convenience init?(from dictionary: [String: Any]) {
        guard let numberOfLikes = dictionary[CocktailKeys.numberOfLikes] as? Int,
            let cocktailName = dictionary[CocktailKeys.cocktailName] as? String,
              let instruction = dictionary[CocktailKeys.instruction] as? String,
              let glass = dictionary[CocktailKeys.glass] as? String,
              let uuid = dictionary[CocktailKeys.uuid] as? String,
              let ingredientsArray = dictionary[CocktailKeys.ingredients] as? [[String : Any]],
              let imageURL = dictionary[CocktailKeys.imageURL] as? String else { return nil }
        let ingredients = ingredientsArray.compactMap({CustomIngredient(from: $0)})
        
        self.init(numberOfLikes: numberOfLikes,
                  cocktailName: cocktailName,
                  glass: glass,
                  instruction: instruction,
                  uuid: uuid,
                  ingredients: ingredients,
                  imageURL: imageURL)
    }
}

    extension CustomCocktail: Equatable {
        static func == (lhs: CustomCocktail, rhs: CustomCocktail) -> Bool {
            return lhs.uuid == rhs.uuid
        }
    }


