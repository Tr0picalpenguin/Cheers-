//
//  CreateUserViewController.swift
//  Cheers!
//
//  Created by Scott Cox on 7/7/22.
//

import UIKit
import AuthenticationServices

class CreateUserViewController: UIViewController {

    

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var appleLoginStackView: UIStackView!
    
    
    var viewModel: CreateUserViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = CreateUserViewModel(delegate: self)
        setupAppleLoginButton()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
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
    
    func setupAppleLoginButton() {
        let authorizationButton = ASAuthorizationAppleIDButton()
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        self.appleLoginStackView.addArrangedSubview(authorizationButton)
    }
    
    func performExistingAccountSetupFlows() {
        // Prepare requests for both Apple ID and password providers.
        let requests = [ASAuthorizationAppleIDProvider().createRequest(),
                        ASAuthorizationPasswordProvider().createRequest()]
        
        // Create an authorization controller with the given requests.
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        viewModel.startSignInWithAppleFlow(delegate: self, presentationProvider: self)
//        let appleIDProvider = ASAuthorizationAppleIDProvider()
//        let request = appleIDProvider.createRequest()
//        request.requestedScopes = [.fullName, .email]
//        
//        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
//        authorizationController.delegate = self
//        authorizationController.presentationContextProvider = self
//        authorizationController.performRequests()
    }
}// end of class

extension CreateUserViewController: CreateUserViewModelDelegate {
    func presentAlertController(error: Error) {
        let alertController = UIAlertController(title: "Error", message: "(error.localizedDescription)", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Close", style: .cancel))
                        present(alertController, animated: true)
    }
    
    func userSignedIn() {
        let storyboard = UIStoryboard(name: "TabController", bundle: nil)
                guard let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarName") as? UITabBarController else { return }
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(viewController: tabBarController)
    }
}

extension CreateUserViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = viewModel.currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
              }
              guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
              }
              guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
              }
            // Need to set the user defaults
            viewModel.signInWithApple(token: idTokenString, nonce: nonce)
            }
          }

          func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
            // Handle error.
            print("Sign in with Apple errored: \(error)")
          }
    
}
