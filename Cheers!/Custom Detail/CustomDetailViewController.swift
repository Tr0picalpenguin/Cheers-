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
    @IBOutlet weak var ingredientsTableView: UITableView!
    
    var customDetailViewModel: CustomDetailViewModel!
    var customCocktail: [CustomCocktail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        updateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
//    var defaultLikes: Int = 0
    
    func increaseLikesCount(_ numberOfLikesLabel: UILabel) {
        guard let currentLikes = Int(numberOfLikesLabel.text ?? "0") else {
            print("Error: Couldn't convert likes label text to Int.")
            return
        }
        let newLikes = currentLikes + 1
        numberOfLikesLabel.text = "\(newLikes)"
        guard let cocktail = customDetailViewModel.cocktail else { return }
        customDetailViewModel.updateLikes(with: cocktail)
    }
    
    func updateViews() {
        guard let customCocktail = customDetailViewModel.cocktail else { return }
        customCocktailNameLabel.text = customCocktail.cocktailName
        glassLabel.text = customCocktail.glass
        numberOfLikesLabel.text = "\(customCocktail.numberOfLikes)"
        instructionsTextView.text = customCocktail.instruction
        if let imageURL = customCocktail.imageURL {
            self.customImageView.fetchImage(using: imageURL)
        }
        self.ingredientsTableView.reloadData()
    }
    
    @IBAction func reportButtonTapped(_ sender: Any) {
        // present the alert controller to report the post
        let alertController = UIAlertController(title: "Are you sure you want to report this post?", message: "false reporting will result in acount deactivation.", preferredStyle: .alert)
        let declineAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let confirmAction = UIAlertAction(title: "Report", style: .destructive) { _ in
            self.dismiss(animated: true)
        }
        alertController.addAction(confirmAction)
        alertController.addAction(declineAction)
        present(alertController, animated: true)
    }
    
    //MARK: - need to call the update cocktail function to save the details when the likes button is tapped.
    @IBAction func likesButtonTapped(_ sender: Any) {
        increaseLikesCount(numberOfLikesLabel)
    }
    
} // end of class

extension CustomDetailViewController: CustomDetailViewModelDelegate {
    func customCocktailLoadedSuccessfully() {
        updateViews()
    }
}

extension CustomDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        customDetailViewModel.cocktail?.ingredients.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath) as? IngredientsTableViewCell,
            let customIngredient = customDetailViewModel.cocktail?.ingredients[indexPath.row]
        else { return UITableViewCell() }
        cell.updateViews(ingredient: customIngredient)
        return cell
    }
}



