//
//  CustomCocktail.swift
//  Cheers!
//
//  Created by Scott Cox on 7/11/22.
//

import Foundation

class CustomCocktail {
    
//    enum CocktailKeys {
//            static let cocktailName = "name"
//            static let glass = "glass"
//            static let instruction = "instruction"
//            static let uuid = "uuid"
//            static let collectionType = "cocktails"
//            static let imageURL = "imageURL"
//    }
//
//    let uuid: UUID
//    var cocktailName: String
//    var glass: String?
//    var instruction: String
//    var ingredients: [MeasuredIngredient]
//    var imageURL: URL?
//
//    // MARK: - Dictionary representation
//    var cocktailData: [String : AnyHashable] {
//        ["cocktailName": self.cocktailName,
//         "glass": self.glass,
//         "instruction": self.instruction,
// //        "ingredients": self.ingredients,
//         "imageURL": self.imageURL]
//    }
//
//    init(uuid: UUID = UUID(), cocktailName: String, glass: String?, instruction: String, ingredients: [MeasuredIngredient] = [], imageURL: String = "") {
//
//        self.uuid = uuid
//        self.cocktailName = cocktailName
//        self.glass = glass
//        self.instruction = instruction
//        self.ingredients = ingredients
//
//    }
//}
        enum CocktailKeys {
            static let cocktailName = "name"
            static let glass = "glass"
            static let instruction = "instruction"
            static let uuid = "uuid"
            static let collectionType = "cocktails"
            static let imageURL = "imageURL"
           

        }
        // MARK: - Properties
    var cocktailName: String
    var glass: String?
    var instruction: String
    var uuid: String
    var imageURL: URL?
    var ingredients: [CustomIngredient]
    

        // Dictionary representation
        var cocktailData: [String: AnyHashable] {
            ["cocktailName": self.cocktailName,
             "glass": self.glass,
             "instruction": self.instruction,
             "uuid": self.uuid,
             "imageURL": self.imageURL]
        }

        // MARK: - Initializers
    init(cocktailName: String, glass:String, instruction: String, collectionType: String, uuid: String = UUID().uuidString, imageURL: String = "", ingredients: [CustomIngredient] = []) {

            self.cocktailName = cocktailName
            self.instruction = instruction
            self.glass = glass
            self.uuid = uuid
            self.imageURL = URL(string: imageURL)
            self.ingredients = ingredients
            
        
        }
} // end of class

struct CustomIngredient {
    var ingredient: String
    var measurement: String
}

extension CustomCocktail {

    convenience init?(dictionary: [String: Any]) {
        guard let cocktailName = dictionary[CocktailKeys.cocktailName] as? String,
              let instruction = dictionary[CocktailKeys.instruction] as? String,
              let glass = dictionary[CocktailKeys.glass] as? String,
              let uuid = dictionary[CocktailKeys.uuid] as? String,
              let collectionType = dictionary[CocktailKeys.collectionType] as? String,
              let imageURL = dictionary[CocktailKeys.imageURL] as? String else { return nil }


        self.init(cocktailName: cocktailName,
                  glass: glass,
                  instruction: instruction,
                  collectionType: collectionType,
                  uuid: uuid,
                  imageURL: imageURL)
    }
}

    extension CustomCocktail: Equatable {
        static func == (lhs: CustomCocktail, rhs: CustomCocktail) -> Bool {
            return lhs.uuid == rhs.uuid
        }
    }


