//
//  CocktailDetailViewController.swift
//  Cheers!
//
//  Created by Scott Cox on 7/5/22.
//

import UIKit

class CocktailDetailViewController: UIViewController {

    @IBOutlet weak var cocktailImageView: UIImageView!
    
    @IBOutlet weak var cocktailNameLabel: UILabel!
    @IBOutlet weak var glassTypeLabel: UILabel!
    @IBOutlet weak var intstructionsTextView: UITextView!
    @IBOutlet weak var likesLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func likeButtonTapped(_ sender: Any) {
    }
    @IBAction func favoritesButtonTapped(_ sender: Any) {
    }
    
} // end of class
