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
    
    var viewModel: UserLoginViewModel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = UserLoginViewModel(delegate: self)
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
        if emailTextField.text?.isEmpty == true {
            let alertController = UIAlertController(title: "No email found!", message: "Please enter a valid email.", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(confirmAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        if passwordTextField.text?.isEmpty == true {
            let alertController = UIAlertController(title: "Password field is empty!", message: "Please enter password", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(confirmAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        if let email = emailTextField.text,
           let password = passwordTextField.text {
            viewModel.loginAuthentication(with: email, password: password)
            
        }
    }
    
   
    
 
    @IBAction func createAccountButtonTapped(_ sender: Any) {
    }
    @IBAction func continueButtonTapped(_ sender: Any) {
    }
    
}

extension UserLoginViewController: UserLoginViewModeldelegate {
    
    func presentAlertController(error: Error) {
        let alertController = UIAlertController(title: "Invalid Login", message: "Please check email and password", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(confirmAction)
        present(alertController, animated: true)
    }
    
    func userLoggedIn() {
        let storyboard = UIStoryboard(name: "TabController", bundle: nil)
                guard let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarName") as? UITabBarController else { return }
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(viewController: tabBarController)
    }
}
