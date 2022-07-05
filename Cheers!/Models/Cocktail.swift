//
//  Cocktail.swift
//  Cheers!
//
//  Created by Scott Cox on 6/30/22.
//

import Foundation

class Cocktail: Codable {
    
    enum Keys {
        static let collectionType = "cocktails"
        static let name = "name"
        static let description = "description"
        static let ingredient = "ingredient"
        static let glass = "glassType"
        static let uuid = "uuid"
        static let imageURL = "imageURL"
    }
    
    // MARK: - Properties
    var name: String
    var description: String
    var ingredient: String
    var glass: String
    let uuid: String
    var imageURL: URL?
    
    var cocktailData: [String: AnyHashable] {
        [Keys.name: self.name,
         Keys.description: self.description,
         Keys.glass: self.glass,
         Keys.ingredient: self.ingredient,
         Keys.uuid: self.uuid,
         Keys.imageURL: self.imageURL]
    }
    
    init(name:String, description: String, ingredient: String, glass: String, uuid: String = UUID().uuidString, imageURL: String = "") {
        self.name = name
        self.description = description
        self.ingredient = ingredient
        self.glass = glass
        self.uuid = uuid
        self.imageURL = URL(string: imageURL)
    }
}

extension Cocktail {
    
    convenience init?(dictionary: [String: Any]) {
        guard let name = dictionary[Keys.name] as? String,
              let description = dictionary[Keys.description] as? String,
              let ingredient = dictionary[Keys.ingredient] as? String,
              let glass = dictionary[Keys.glass] as? String,
              let imageURL = dictionary[Keys.imageURL] as? String,
              let uuid = dictionary[Keys.uuid] as? String else { return nil }
        
        self.init(name: name,
                  description: description,
                  ingredient: ingredient,
                  glass: glass,
                  uuid: uuid,
                  imageURL: imageURL)
    }
}

extension Cocktail: Equatable {
    static func == (lhs: Cocktail, rhs: Cocktail) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
