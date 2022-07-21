//
//  Cocktail.swift
//  Cheers!
//
//  Created by Scott Cox on 6/30/22.
//

import Foundation
import UIKit

struct TopLevelDictionary: Decodable {
    private enum CodingKeys: String, CodingKey {
        case drinks
    }
    let drinks: [Cocktail]
}

struct Cocktail: Decodable {
    private enum CodingKeys: String, CodingKey {
        case cocktailID = "idDrink"
        case name = "strDrink"
        case imageURL = "strDrinkThumb"
        
    }
    var cocktailID: String
    var name: String
    var imageURL: String?
}

struct CoctailDetailTopLevelDictionary: Decodable {
    let drinks: [CocktailDetail]
}

struct CocktailDetail: Decodable {
    
    enum CodingKeys: String, CodingKey {
        
        case cocktailID = "idDrink"
        case name = "strDrink"
        case instruction = "strInstructions"
        case glass = "strGlass"
        case imageURL = "strDrinkThumb"
        case ingredient1 = "strIngredient1"
        case ingredient2 = "strIngredient2"
        case ingredient3 = "strIngredient3"
        case ingredient4 = "strIngredient4"
        case ingredient5 = "strIngredient5"
        case ingredient6 = "strIngredient6"
        case ingredient7 = "strIngredient7"
        case ingredient8 = "strIngredient8"
        case ingredient9 = "strIngredient9"
        case ingredient10 = "strIngredient10"
        case ingredient11 = "strIngredient11"
        case ingredient12 = "strIngredient12"
        case ingredient13 = "strIngredient13"
        case ingredient14 = "strIngredient14"
        case ingredient15 = "strIngredient15"
        case measurement1 = "strMeasure1"
        case measurement2 = "strMeasure2"
        case measurement3 = "strMeasure3"
        case measurement4 = "strMeasure4"
        case measurement5 = "strMeasure5"
        case measurement6 = "strMeasure6"
        case measurement7 = "strMeasure7"
        case measurement8 = "strMeasure8"
        case measurement9 = "strMeasure9"
        case measurement10 = "strMeasure10"
        case measurement11 = "strMeasure11"
        case measurement12 = "strMeasure12"
        case measurement13 = "strMeasure13"
        case measurement14 = "strMeasure14"
        case measurement15 = "strMeasure15"
    }
                        
    // MARK: - Properties
    var cocktailID: String
    var name: String
    var instruction: String
    var glass: String
    var imageURL: String?
    var ingredient1: String?
    var ingredient2: String?
    var ingredient3: String?
    var ingredient4: String?
    var ingredient5: String?
    var ingredient6: String?
    var ingredient7: String?
    var ingredient8: String?
    var ingredient9: String?
    var ingredient10: String?
    var ingredient11: String?
    var ingredient12: String?
    var ingredient13: String?
    var ingredient14: String?
    var ingredient15: String?
    var measurement1: String?
    var measurement2: String?
    var measurement3: String?
    var measurement4: String?
    var measurement5: String?
    var measurement6: String?
    var measurement7: String?
    var measurement8: String?
    var measurement9: String?
    var measurement10: String?
    var measurement11: String?
    var measurement12: String?
    var measurement13: String?
    var measurement14: String?
    var measurement15: String?
}

