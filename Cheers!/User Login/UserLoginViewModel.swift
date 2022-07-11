//
//  UserLoginViewModel.swift
//  Cheers!
//
//  Created by Scott Cox on 7/7/22.
//

import Foundation

class UserLogin {
    
    let usernameTest = "test user"
    let passwordTest = "password123"
    let emailTest = "test@email.com"
    
    func userLogin(with username: String, and password: String) {
        
        
        let user = User(username: usernameTest, password: passwordTest, email: emailTest, profilePicture: nil)
    }
}

// I think I need an extension that checks user equatability to determine if they can login or not.
