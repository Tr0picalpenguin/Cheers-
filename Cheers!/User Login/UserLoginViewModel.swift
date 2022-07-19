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
    
    init(user: User? = nil, firebaseService: FirebaseSyncable = FirebaseService()) {
        self.user = user
        self.service = firebaseService
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
//       //TODO: - abstract firebase code to FirebaseService
//        Auth.auth().signIn(withEmail: email, password: password) { result, error in
//            switch result {
//            case .none:
//                // MARK: - need a protocol and delegate to present the alert controller
//                self.delegate?.presentAlertController()
//
//
//            case .some(let userDetails):
//                print("Cheers!", userDetails.user.email!)
//                UserDefaults.standard.set(userDetails.user.email, forKey: "email")
//                let storyboard = UIStoryboard(name: "TabController", bundle: nil)
//                guard let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarName") as? UITabBarController else { return }
//
//                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(viewController: tabBarController)
//
//            }
//        }
//
    
} // end of class





