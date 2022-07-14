//
//  CreateUserViewController.swift
//  Cheers!
//
//  Created by Scott Cox on 7/7/22.
//

import UIKit

class CreateUserViewController: UIViewController {

    

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    var viewModel: CreateUserViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = CreateUserViewModel(delegate: self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func createAccountButtonTapped(_ sender: Any) {
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
        if confirmPasswordTextField.text?.isEmpty == true {
            let alertController = UIAlertController(title: "Confirm password is empty!", message: "Please confirm password.", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(confirmAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        if passwordTextField.text != confirmPasswordTextField.text {
            let alertController = UIAlertController(title: "Passwords do not match!", message: "Please check password.", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(confirmAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let confirmPassword = confirmPasswordTextField.text else { return }
        viewModel.createUser(with: email, password: password, confirmPassword: confirmPassword)
    }
    
    @IBAction func returnToLoginButtonTapped(_ sender: Any) {
    }
    
}

extension CreateUserViewController: CreateUserViewModelDelegate {
    func presentAlertController(error: Error) {
        let alertController = UIAlertController(title: "Error", message: "(error.localizedDescription)", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Close", style: .cancel))
                        present(alertController, animated: true)
    }
    
    func userSignedIn() {
        let storyboard = UIStoryboard(name: "TabBarController", bundle: nil)
                guard let tabBarController = storyboard.instantiateViewController(withIdentifier: "Home") as? UITabBarController else { return }
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(viewController: tabBarController)
    }
    
    
    
}
