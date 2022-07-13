//
//  UserLoginViewController.swift
//  Cheers!
//
//  Created by Scott Cox on 7/7/22.
//

import UIKit
import FirebaseAuth
import SwiftUI

class UserLoginViewController: UIViewController {

    @IBOutlet weak var appNameLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func loginButtonTapped(_ sender: Any) {
        if let email = emailTextField.text,
           let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                switch result {
                case .none:
                    let alertController = UIAlertController(title: "Invalid Login", message: "Please check email and password", preferredStyle: .alert)
                    let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alertController.addAction(confirmAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                case .some(let userDetails):
                    print("Cheers!", userDetails.user.email!)
                    
                    let storyboard = UIStoryboard(name: "TabController", bundle: nil)
                    guard let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarName") as? UITabBarController else { return }
       //             tabBarController.modalPresentationStyle = .overFullScreen
                    
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(viewController: tabBarController)
 //                   self.present(tabBarController, animated: true)
                }
            }
        }
    }
    
// TODO: - 
    @IBAction func signInWithAppleButtonTapped(_ sender: Any) {
    }
    @IBAction func createAccountButtonTapped(_ sender: Any) {
    }
    @IBAction func continueButtonTapped(_ sender: Any) {
    }
    
}
