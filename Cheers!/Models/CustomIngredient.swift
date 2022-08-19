//
//  CustomIngredient.swift
//  Cheers!
//
//  Created by Scott Cox on 8/12/22.
//

import Foundation


struct CustomIngredient {
    
    enum Ingredientkeys {
        static let ingredient = "ingredient"
        static let measurement = "measurement"
    }
    var ingredient: String
    var measurement: String
    
    var ingredientData: [String : Any] {
        [Ingredientkeys.ingredient: self.ingredient,
         Ingredientkeys.measurement: self.measurement]
    }
    
    init(ingredient: String, measurement: String) {
        self.ingredient = ingredient
        self.measurement = measurement
    }
    
    init?(from dictionary: [String : Any]) {
        guard let ingredient = dictionary[Ingredientkeys.ingredient] as? String,
              let measurement = dictionary[Ingredientkeys.measurement] as? String else { return nil }
        
        self.init(ingredient: ingredient, measurement: measurement)
    }
}
