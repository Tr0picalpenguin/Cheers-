//
//  CreateUserViewModel.swift
//  Cheers!
//
//  Created by Scott Cox on 7/7/22.
//

import Foundation

class CreateUser {
    
    func createUser(with username: String, password: String, email: String, profilePicture: URL?) {
        
        //mock data
        let usernameTest = "test user"
        let passwordTest = "password123"
        let emailTest = "test@email.com"
        
        
        
        let newUser = User(username: usernameTest, password: passwordTest, email: emailTest, profilePicture: nil)
    }
}
