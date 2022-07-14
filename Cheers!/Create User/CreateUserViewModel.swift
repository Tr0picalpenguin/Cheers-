//
//  CreateUserViewModel.swift
//  Cheers!
//
//  Created by Scott Cox on 7/7/22.
//

import Foundation

protocol CreateUserViewModelDelegate: AnyObject {
    func presentAlertController(error: Error)
    func userSignedIn()
}

class CreateUserViewModel {
    
    private var service: FirebaseSyncable?
    private weak var delegate: CreateUserViewModelDelegate?
    
    init(service: FirebaseSyncable = FirebaseService(), delegate: CreateUserViewModelDelegate) {
        self.service = service
        self.delegate = delegate
    }
   
    func createUser(with email: String, password: String, confirmPassword: String) {
        service?.createUser(with: email, password: password) { result in
            switch result {
            case .success:
                self.delegate?.userSignedIn()
            case .failure(let error):
                self.delegate?.presentAlertController(error: error)
            }
        }
    }
} // end of class
