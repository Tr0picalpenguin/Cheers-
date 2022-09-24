//
//  User.swift
//  Cheers!
//
//  Created by Scott Cox on 6/30/22.
//

import Foundation

class User: Codable {
    
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
    
    init(email: String, uuid: String, customcocktails: [CustomCocktail], collectionType: String = "users") {
        self.email = email
        self.uuid = uuid
        self.customCocktails = customcocktails
        self.collectionType = collectionType
    }
    
    convenience init?(from dictionary: [String : Any]) {
        guard let email = dictionary[Keys.email] as? String,
              let uuid = dictionary[Keys.uuid] as? String,
              let customCocktailsArray = dictionary[Keys.customCocktails] as? [[String : Any]],
              let collectionType = dictionary[Keys.collectionType] as? String else { return nil }
        let customCocktails = customCocktailsArray.compactMap({CustomCocktail(from: $0)})
        self.init(email: email, uuid: uuid, customcocktails: customCocktails, collectionType: collectionType)
    }
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
