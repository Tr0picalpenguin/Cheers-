//
//  UserLoginViewModel.swift
//  Cheers!
//
//  Created by Scott Cox on 7/7/22.
//
import UIKit
import Foundation
import FirebaseAuth


protocol UserLoginViewModeldelegate: AnyObject {
    func presentAlertController(error: Error)
    func userLoggedIn()
}

class UserLoginViewModel {
    
    private weak var delegate: UserLoginViewModeldelegate?
    var user: User?
    private let service: FirebaseSyncable
    
    init(user: User? = nil, delegate: UserLoginViewModeldelegate, firebaseService: FirebaseSyncable = FirebaseService()) {
        self.user = user
        self.service = firebaseService
        self.delegate = delegate
    }
    
    func loginAuthentication(with email: String, password: String) {
        service.loginUser(with: email, password: password) { result in
            switch result {
            case .success(true):
                self.delegate?.userLoggedIn()
            case .success(false):
                let error = Error.self
                self.delegate?.presentAlertController(error: error as! Error )
            case .failure(let error):
                self.delegate?.presentAlertController(error: error)
                    
                }
            }
        }

    
} // end of class



