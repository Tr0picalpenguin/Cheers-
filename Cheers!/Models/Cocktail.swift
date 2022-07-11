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

struct Cocktail: Codable {
    
    enum CodingKeys: String, CodingKey {
        //        static let collectionType = "cocktails"
        case drinkID = "idDrink"
        case name = "strDrink"
        case instruction = "strInstructions"
        case glass = "strGlass"
  //      case uuid = "uuid"
        case imageURL = "strImageSource"
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
    var drinkID: String
    var name: String
    var instruction: String
    var glass: String
 //   let uuid: String
    var imageURL: URL?
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
    
    //    var cocktailData: [String: AnyHashable] {
    //        [Keys.drinkID: self.drinkID,
    //         Keys.name: self.name,
    //         Keys.instruction: self.instruction,
    //         Keys.glass: self.glass,
    //         Keys.uuid: self.uuid,
    //         Keys.imageURL: self.imageURL,
    //         Keys.ingredient1: self.ingredient1,
    //         Keys.ingredient2: self.ingredient2,
    //         Keys.ingredient3: self.ingredient3,
    //         Keys.ingredient4: self.ingredient4,
    //         Keys.ingredient5: self.ingredient5,
    //         Keys.ingredient6: self.ingredient6,
    //         Keys.ingredient7: self.ingredient7,
    //         Keys.ingredient8: self.ingredient8,
    //         Keys.ingredient9: self.ingredient9,
    //         Keys.ingredient10: self.ingredient10,
    //         Keys.ingredient11: self.ingredient11,
    //         Keys.ingredient12: self.ingredient12,
    //         Keys.ingredient13: self.ingredient13,
    //         Keys.ingredient14: self.ingredient14,
    //         Keys.ingredient15: self.ingredient15,
    //         Keys.measurement1: self.measurement1,
    //         Keys.measurement2: self.measurement2,
    //         Keys.measurement3: self.measurement3,
    //         Keys.measurement4: self.measurement4,
    //         Keys.measurement5: self.measurement5,
    //         Keys.measurement6: self.measurement6,
    //         Keys.measurement7: self.measurement7,
    //         Keys.measurement8: self.measurement8,
    //         Keys.measurement9: self.measurement9,
    //         Keys.measurement10: self.measurement10,
    //         Keys.measurement11: self.measurement11,
    //         Keys.measurement12: self.measurement12,
    //         Keys.measurement13: self.measurement13,
    //         Keys.measurement14: self.measurement14,
    //         Keys.measurement15: self.measurement15]
    //    }
    //
    //    init(dinkID: String, name:String, instruction: String, glass: String, uuid: String = UUID().uuidString, imageURL: String, ingredient1: String, ingredient2: String, ingredient3: String, ingredient4: String, ingredient5: String, ingredient6: String, ingredient7: String, ingredient8: String, ingredient9: String, ingredient10: String, ingredient11: String, ingredient12: String, ingredient13: String, ingredient14: String, ingredient15: String, measurement1: String, measurement2: String, measurement3: String, measurement4: String, measurement5: String?, measurement6: String, measurement7: String, measurement8: String, measurement9: String, measurement10: String, measurement11: String, measurement12: String, measurement13: String, measurement14: String, measurement15: String) {
    //        self.drinkID = dinkID
    //        self.name = name
    //        self.instruction = instruction
    //        self.glass = glass
    //        self.uuid = uuid
    //        self.imageURL = URL(string: imageURL)
    //        self.ingredient1 = ingredient1
    //        self.ingredient2 = ingredient2
    //        self.ingredient3 = ingredient3
    //        self.ingredient4 = ingredient4
    //        self.ingredient5 = ingredient5
    //        self.ingredient6 = ingredient6
    //        self.ingredient7 = ingredient7
    //        self.ingredient8 = ingredient8
    //        self.ingredient9 = ingredient9
    //        self.ingredient10 = ingredient10
    //        self.ingredient11 = ingredient11
    //        self.ingredient12 = ingredient12
    //        self.ingredient13 = ingredient13
    //        self.ingredient14 = ingredient14
    //        self.ingredient15 = ingredient15
    //        self.measurement1 = measurement1
    //        self.measurement2 = measurement2
    //        self.measurement3 = measurement3
    //        self.measurement4 = measurement4
    //        self.measurement5 = measurement5
    //        self.measurement6 = measurement6
    //        self.measurement7 = measurement7
    //        self.measurement8 = measurement8
    //        self.measurement9 = measurement9
    //        self.measurement10 = measurement10
    //        self.measurement11 = measurement11
    //        self.measurement12 = measurement12
    //        self.measurement13 = measurement13
    //        self.measurement14 = measurement14
    //        self.measurement15 = measurement15
    //    }
} // end of struct

//extension Cocktail {
//
//    convenience init?(dictionary: [String: Any]) {
//        guard let drinkID = dictionary[Keys.drinkID] as? String,
//              let name = dictionary[Keys.name] as? String,
//              let instruction = dictionary[Keys.instruction] as? String,
//              let glass = dictionary[Keys.glass] as? String,
//              let imageURL = dictionary[Keys.imageURL] as? String,
//              let uuid = dictionary[Keys.uuid] as? String,
//              let ingredient1 = dictionary[Keys.ingredient1] as? String,
//              let ingredient2 = dictionary[Keys.ingredient2] as? String,
//              let ingredient3 = dictionary[Keys.ingredient3] as? String,
//              let ingredient4 = dictionary[Keys.ingredient4] as? String,
//              let ingredient5 = dictionary[Keys.ingredient5] as? String,
//              let ingredient6 = dictionary[Keys.ingredient6] as? String,
//              let ingredient7 = dictionary[Keys.ingredient7] as? String,
//              let ingredient8 = dictionary[Keys.ingredient8] as? String,
//              let ingredient9 = dictionary[Keys.ingredient9] as? String,
//              let ingredient10 = dictionary[Keys.ingredient10] as? String,
//              let ingredient11 = dictionary[Keys.ingredient11] as? String,
//              let ingredient12 = dictionary[Keys.ingredient12] as? String,
//              let ingredient13 = dictionary[Keys.ingredient13] as? String,
//              let ingredient14 = dictionary[Keys.ingredient14] as? String,
//              let ingredient15 = dictionary[Keys.ingredient15] as? String,
//              let measurement1 = dictionary[Keys.measurement1] as? String,
//              let measurement2 = dictionary[Keys.measurement2] as? String,
//              let measurement3 = dictionary[Keys.measurement3] as? String,
//              let measurement4 = dictionary[Keys.measurement4] as? String,
//              let measurement5 = dictionary[Keys.measurement5] as? String,
//              let measurement6 = dictionary[Keys.measurement6] as? String,
//              let measurement7 = dictionary[Keys.measurement7] as? String,
//              let measurement8 = dictionary[Keys.measurement8] as? String,
//              let measurement9 = dictionary[Keys.measurement9] as? String,
//              let measurement10 = dictionary[Keys.measurement10] as? String,
//              let measurement11 = dictionary[Keys.measurement11] as? String,
//              let measurement12 = dictionary[Keys.measurement12] as? String,
//              let measurement13 = dictionary[Keys.measurement13] as? String,
//              let measurement14 = dictionary[Keys.measurement14] as? String,
//              let measurement15 = dictionary[Keys.measurement15] as? String else { return nil }
//
//        self.init(dinkID: drinkID,
//                  name: name,
//                  instruction: instruction,
//                  glass: glass,
//                  uuid: uuid,
//                  imageURL: imageURL,
//                  ingredient1: ingredient1,
//                  ingredient2: ingredient2,
//                  ingredient3: ingredient3,
//                  ingredient4: ingredient4,
//                  ingredient5: ingredient5,
//                  ingredient6: ingredient6,
//                  ingredient7: ingredient7,
//                  ingredient8: ingredient8,
//                  ingredient9: ingredient9,
//                  ingredient10: ingredient10,
//                  ingredient11: ingredient11,
//                  ingredient12: ingredient12,
//                  ingredient13: ingredient13,
//                  ingredient14: ingredient14,
//                  ingredient15: ingredient15,
//                  measurement1: measurement1,
//                  measurement2: measurement2,
//                  measurement3: measurement3,
//                  measurement4: measurement4,
//                  measurement5: measurement5,
//                  measurement6: measurement6,
//                  measurement7: measurement7,
//                  measurement8: measurement8,
//                  measurement9: measurement9,
//                  measurement10: measurement10,
//                  measurement11: measurement11,
//                  measurement12: measurement12,
//                  measurement13: measurement13,
//                  measurement14: measurement14,
//                  measurement15: measurement15)
//    }
//}

//extension Cocktail: Equatable {
//    static func == (lhs: Cocktail, rhs: Cocktail) -> Bool {
//        return lhs.uuid == rhs.uuid
//    }
//}


