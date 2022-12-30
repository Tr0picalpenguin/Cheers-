//
//  CustomDetailViewController.swift
//  Cheers!
//
//  Created by Scott Cox on 11/2/22.
//

import UIKit

class CustomDetailViewController: UIViewController {

    @IBOutlet weak var numberOfLikesLabel: UILabel!
    
    @IBOutlet weak var customImageView: CocktailImageView!
    @IBOutlet weak var customCocktailNameLabel: UILabel!
    
    @IBOutlet weak var glassLabel: UILabel!
    
    @IBOutlet weak var instructionsTextView: UITextView!
    
    var customDetailViewModel: CustomDetailViewModel!
    var customCocktail: [CustomCocktail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func updateViews() {
        guard let customCocktail = customDetailViewModel.cocktail else { return }
        customCocktailNameLabel.text = customCocktail.cocktailName
        glassLabel.text = customCocktail.glass
        numberOfLikesLabel.text = "\(customCocktail.numberOfLikes)"
        instructionsTextView.text = customCocktail.instruction
        // need to add the image
        }
    var defaultLikes: Int = 0
    
    @IBAction func reportButtonTapped(_ sender: Any) {
        // present the alert controller to report the post
        let alertController = UIAlertController(title: "Are you sure you want to report this post?", message: "false reporting will result in acount deactivation.", preferredStyle: .alert)
        let declineAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let confirmAction = UIAlertAction(title: "Report", style: .destructive) { _ in
           // this is the code to report the the post
        }
        alertController.addAction(confirmAction)
        alertController.addAction(declineAction)
        present(alertController, animated: true)
    }
    
    @IBAction func likesButtonTapped(_ sender: Any) {
        let currentLikes = defaultLikes
        defaultLikes += 1
        numberOfLikesLabel.text = "\(currentLikes)"
    }
    
    }

   
    
    
