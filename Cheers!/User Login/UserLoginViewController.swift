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
    
    let viewModel: UserLoginViewModel = UserLoginViewModel()

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
            viewModel.loginAuthentication(with: email, password: password)
        }
    }
    
   
    
 
    @IBAction func createAccountButtonTapped(_ sender: Any) {
    }
    @IBAction func continueButtonTapped(_ sender: Any) {
    }
    
}

extension UserLoginViewController: UserLoginViewModeldelegate {
    func presentAlertController() {
        let alertController = UIAlertController(title: "Invalid Login", message: "Please check email and password", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(confirmAction)
        present(alertController, animated: true)
    }
}
