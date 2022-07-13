//
//  CocktailDetailViewController.swift
//  Cheers!
//
//  Created by Scott Cox on 7/5/22.
//

import UIKit

class CocktailDetailViewController: UIViewController {

    @IBOutlet weak var cocktailImageView: CocktailImageView!
    
    @IBOutlet weak var cocktailNameLabel: UILabel!
    @IBOutlet weak var glassTypeLabel: UILabel!
    @IBOutlet weak var intstructionsTextView: UITextView!
    @IBOutlet weak var likesLabel: UILabel!
    
    @IBOutlet weak var ingredientsTableView: UITableView!
    
    var cocktailDetailViewModel: CocktailDetailViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
   
    // I need to display the details of the cocktail AND figure out why the image gets a BAD_ACCESS error
    func updateViews() {
        guard let cocktail = cocktailDetailViewModel.cocktail else { return }
        if let imageURL = cocktail.imageURL {
            self.cocktailImageView.fetchImage(using: imageURL)
        }
        self.cocktailNameLabel.text = cocktail.name.capitalized
        self.glassTypeLabel.text = cocktail.glass
        self.intstructionsTextView.text = cocktail.instruction
        
    }
    
   
    
   
    

    
    @IBAction func likeButtonTapped(_ sender: Any) {
    }
    @IBAction func favoritesButtonTapped(_ sender: Any) {
    }
    
} // end of class

extension CocktailDetailViewController: CocktailDetailViewModeldelegate {
    func cocktailLoadedSuccessfully() {
        updateViews()
    }
}

// need to add the ingredeients tableView dataSource methods
//extension CocktailDetailViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//    }
//    
//    
//}

