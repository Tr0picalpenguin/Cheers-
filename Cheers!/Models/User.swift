//
//  User.swift
//  Cheers!
//
//  Created by Scott Cox on 6/30/22.
//

import Foundation

struct User {
    
    enum Keys {
        static let username = "username"
        static let password = "password"
        static let email = "email"
        static let uuid = "uuid"
        static let customCocktails = "customCocktails"
        static let collectionType = "users"
    }
    
    // MARK: - Properties
    let username: String
    let password: String
    let email: String
    let uuid: String
    var customCocktails: [CustomCocktail]
    let collectionType: String
    
    // Dictionary representation
    var userData: [String : Any] {
        [Keys.username : self.username,
         Keys.password : self.password,
         Keys.email : self.email,
         Keys.uuid : self.uuid,
         Keys.customCocktails : self.customCocktails.map {$0.cocktailData}]
    }
}
