//
//  CreateUserViewController.swift
//  Cheers!
//
//  Created by Scott Cox on 7/7/22.
//

import UIKit

class CreateUserViewController: UIViewController {

    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    }
    // return to login button returns to the right screen but adds a "back button" in the top left. I want this to return to the initial login screen and not give an option to hit "back" to move to the create user screen.
    @IBAction func returnToLoginButtonTapped(_ sender: Any) {
    }
    
}
