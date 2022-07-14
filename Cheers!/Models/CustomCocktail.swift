//
//  CustomCocktail.swift
//  Cheers!
//
//  Created by Scott Cox on 7/11/22.
//

import Foundation

class CustomCocktail: Codable {
    
        
        enum CocktailKeys {
            static let cocktailName = "name"
            static let glass = "glass"
            static let instruction = "instruction"
            static let uuid = "uuid"
            static let collectionType = "cocktails"
            static let imageURL = "imageURL"
            static let ingredient1 = "ingredient1"
            static let ingredient2 = "ingredient2"
            static let ingredient3 = "ingredient3"
            static let ingredient4 = "ingredient4"
            static let ingredient5 = "ingredient5"
            static let ingredient6 = "ingredient6"
            static let ingredient7 = "ingredient7"
            static let ingredient8 = "ingredient8"
            static let ingredient9 = "ingredient9"
            static let ingredient10 = "ingredient10"
            static let ingredient11 = "ingredient11"
            static let ingredient12 = "ingredient12"
            static let ingredient13 = "ingredient13"
            static let ingredient14 = "ingredient14"
            static let ingredient15 = "ingredient15"
            static let measurement1 = "measure1"
            static let measurement2 = "measure2"
            static let measurement3 = "measure3"
            static let measurement4 = "measure4"
            static let measurement5 = "measure5"
            static let measurement6 = "measure6"
            static let measurement7 = "measure7"
            static let measurement8 = "measure8"
            static let measurement9 = "measure9"
            static let measurement10 = "measure10"
            static let measurement11 = "measure11"
            static let measurement12 = "measure12"
            static let measurement13 = "measure13"
            static let measurement14 = "measure14"
            static let measurement15 = "measure15"
            
        }
        // MARK: - Properties
    var cocktailName: String
    var glass: String?
    var instruction: String
    var uuid: String
    var collectionType: String
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
      
        
        // Dictionary representation
        var cocktailData: [String: AnyHashable] {
            ["cocktailName": self.cocktailName,
             "glass": self.glass,
             "instruction": self.instruction,
             "uuid": self.uuid,
             "collectionType": self.collectionType,
             "imageURL": self.imageURL,
             "ingredient1": self.ingredient1,
             "ingredient2": self.ingredient2,
             "ingredient3": self.ingredient3,
             "ingredient4": self.ingredient4,
             "ingredient5": self.ingredient5,
             "ingredient6": self.ingredient6,
             "ingredient7": self.ingredient7,
             "ingredient8": self.ingredient8,
             "ingredient9": self.ingredient9,
             "ingredient10": self.ingredient10,
             "ingredient11": self.ingredient11,
             "ingredient12": self.ingredient12,
             "ingredient13": self.ingredient13,
             "ingredient14": self.ingredient14,
             "ingredient15": self.ingredient15,
             "measurement1": self.measurement1,
             "measurement2": self.measurement2,
             "measurement3": self.measurement3,
             "measurement4": self.measurement4,
             "measurement5": self.measurement5,
             "measurement6": self.measurement6,
             "measurement7": self.measurement7,
             "measurement8": self.measurement8,
             "measurement9": self.measurement9,
             "measurement10": self.measurement10,
             "measurement11": self.measurement11,
             "measurement12": self.measurement12,
             "measurement13": self.measurement13,
             "measurement14": self.measurement14,
             "measurement15": self.measurement15]
        }
        
        // MARK: - Initializers
    init(cocktailName: String, glass:String, instruction: String, collectionType: String, uuid: String = UUID().uuidString, imageURL: String = "", ingredient1: String?, ingredient2: String?, ingredient3: String?, ingredient4: String?, ingredient5: String?, ingredient6: String?, ingredient7: String?, ingredient8: String?, ingredient9: String?, ingredient10: String?, ingredient11: String?, ingredient12: String?, ingredient13: String?, ingredient14: String?, ingredient15: String, measurement1: String, measurement2: String, measurement3: String, measurement4: String, measurement5: String, measurement6: String?, measurement7: String?, measurement8: String?, measurement9: String?, measurement10: String?, measurement11: String?, measurement12: String?, measurement13: String?, measurement14: String?, measurement15: String?) {
            
            self.cocktailName = cocktailName
            self.instruction = instruction
            self.glass = glass
            self.uuid = uuid
            self.collectionType = collectionType
            self.imageURL = URL(string: imageURL)
            self.ingredient1 = ingredient1
            self.ingredient2 = ingredient2
            self.ingredient3 = ingredient3
            self.ingredient4 = ingredient4
            self.ingredient5 = ingredient5
            self.ingredient6 = ingredient6
            self.ingredient7 = ingredient7
            self.ingredient8 = ingredient8
            self.ingredient9 = ingredient9
            self.ingredient10 = ingredient10
            self.ingredient11 = ingredient11
            self.ingredient12 = ingredient12
            self.ingredient13 = ingredient13
            self.ingredient14 = ingredient14
            self.ingredient15 = ingredient15
            self.measurement1 = measurement1
            self.measurement2 = measurement2
            self.measurement3 = measurement3
            self.measurement4 = measurement4
            self.measurement5 = measurement5
            self.measurement6 = measurement6
            self.measurement7 = measurement7
            self.measurement8 = measurement8
            self.measurement9 = measurement9
            self.measurement10 = measurement10
            self.measurement11 = measurement11
            self.measurement12 = measurement12
            self.measurement13 = measurement13
            self.measurement14 = measurement14
            self.measurement15 = measurement15
        }
} // end of class

extension CustomCocktail {

    convenience init?(dictionary: [String: Any]) {
        guard let cocktailName = dictionary[CocktailKeys.cocktailName] as? String,
              let instruction = dictionary[CocktailKeys.instruction] as? String,
              let glass = dictionary[CocktailKeys.glass] as? String,
              let collectionType = dictionary[CocktailKeys.collectionType] as? String,
              let uuid = dictionary[CocktailKeys.uuid] as? String,
              let imageURL = dictionary[CocktailKeys.imageURL] as? String,
              let ingredient1 = dictionary[CocktailKeys.ingredient1] as? String,
              let ingredient2 = dictionary[CocktailKeys.ingredient2] as? String,
              let ingredient3 = dictionary[CocktailKeys.ingredient3] as? String,
              let ingredient4 = dictionary[CocktailKeys.ingredient4] as? String,
              let ingredient5 = dictionary[CocktailKeys.ingredient5] as? String,
              let ingredient6 = dictionary[CocktailKeys.ingredient6] as? String,
              let ingredient7 = dictionary[CocktailKeys.ingredient7] as? String,
              let ingredient8 = dictionary[CocktailKeys.ingredient8] as? String,
              let ingredient9 = dictionary[CocktailKeys.ingredient9] as? String,
              let ingredient10 = dictionary[CocktailKeys.ingredient10] as? String,
              let ingredient11 = dictionary[CocktailKeys.ingredient11] as? String,
              let ingredient12 = dictionary[CocktailKeys.ingredient12] as? String,
              let ingredient13 = dictionary[CocktailKeys.ingredient13] as? String,
              let ingredient14 = dictionary[CocktailKeys.ingredient14] as? String,
              let ingredient15 = dictionary[CocktailKeys.ingredient15] as? String,
              let measurement1 = dictionary[CocktailKeys.measurement1] as? String,
              let measurement2 = dictionary[CocktailKeys.measurement2] as? String,
              let measurement3 = dictionary[CocktailKeys.measurement3] as? String,
              let measurement4 = dictionary[CocktailKeys.measurement4] as? String,
              let measurement5 = dictionary[CocktailKeys.measurement5] as? String,
              let measurement6 = dictionary[CocktailKeys.measurement6] as? String,
              let measurement7 = dictionary[CocktailKeys.measurement7] as? String,
              let measurement8 = dictionary[CocktailKeys.measurement8] as? String,
              let measurement9 = dictionary[CocktailKeys.measurement9] as? String,
              let measurement10 = dictionary[CocktailKeys.measurement10] as? String,
              let measurement11 = dictionary[CocktailKeys.measurement11] as? String,
              let measurement12 = dictionary[CocktailKeys.measurement12] as? String,
              let measurement13 = dictionary[CocktailKeys.measurement13] as? String,
              let measurement14 = dictionary[CocktailKeys.measurement14] as? String,
              let measurement15 = dictionary[CocktailKeys.measurement15] as? String else { return nil }
        
        self.init(cocktailName: cocktailName,
                  glass: glass,
                  instruction: instruction,
                  collectionType: collectionType,
                  uuid: uuid,
                  imageURL: imageURL,
                  ingredient1: ingredient1,
                  ingredient2: ingredient2,
                  ingredient3: ingredient3,
                  ingredient4: ingredient4,
                  ingredient5: ingredient5,
                  ingredient6: ingredient6,
                  ingredient7: ingredient7,
                  ingredient8: ingredient8,
                  ingredient9: ingredient9,
                  ingredient10: ingredient10,
                  ingredient11: ingredient11,
                  ingredient12: ingredient12,
                  ingredient13: ingredient13,
                  ingredient14: ingredient14,
                  ingredient15: ingredient15,
                  measurement1: measurement1,
                  measurement2: measurement2,
                  measurement3: measurement3,
                  measurement4: measurement4,
                  measurement5: measurement5,
                  measurement6: measurement6,
                  measurement7: measurement7,
                  measurement8: measurement8,
                  measurement9: measurement9,
                  measurement10: measurement10,
                  measurement11: measurement11,
                  measurement12: measurement12,
                  measurement13: measurement13,
                  measurement14: measurement14,
                  measurement15: measurement15)
    }
}
   
                                        

    extension CustomCocktail: Equatable {
        static func == (lhs: CustomCocktail, rhs: CustomCocktail) -> Bool {
            return lhs.uuid == rhs.uuid
        }
    }


