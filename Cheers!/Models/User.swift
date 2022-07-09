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
        static let profilePicture = "profilePicture"
    }
    // MARK: - Properties
    let username: String
    let password: String
    let email: String
    let profilePicture: URL?
}
