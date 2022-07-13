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
    func presentAlertController()
}

class UserLoginViewModel {
    
    private weak var delegate: UserLoginViewModeldelegate?
    
    
    func loginAuthentication(with email: String, password: String) {
       
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            switch result {
            case .none:
                // MARK: - need a protocol and delegate to present the alert controller
                self.delegate?.presentAlertController()
                
                
            case .some(let userDetails):
                print("Cheers!", userDetails.user.email!)
                UserDefaults.standard.set(userDetails.user.email, forKey: "email")
                let storyboard = UIStoryboard(name: "TabController", bundle: nil)
                guard let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarName") as? UITabBarController else { return }
                
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(viewController: tabBarController)

            }
        }
    }
}


