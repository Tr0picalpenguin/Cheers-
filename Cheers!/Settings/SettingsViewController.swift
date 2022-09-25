//
//  SettingsViewController.swift
//  Cheers!
//
//  Created by Scott Cox on 9/12/22.
//

import UIKit

class SettingsViewController: UIViewController {

    var viewModel = SettingsViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        closeView()
    }
    
    @objc func closeView() {
        self.dismiss(animated: true)
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        viewModel.logout()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "LoginView")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(viewController: mainViewController)
    }
    
    @IBAction func deleteAccountButtonTapped(_ sender: Any) {
        viewModel.deleteUser()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "LoginView")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(viewController: mainViewController)
    }
}
