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
    @IBOutlet weak var instructionsTextView: UITextView!
    @IBOutlet weak var ingredientTableView: UITableView!
   
    
    var cocktailDetailViewModel: CocktailDetailViewModel!
    var cocktail: [CocktailDetail] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientTableView.delegate = self
        ingredientTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func updateViews() {
        guard let cocktail = cocktailDetailViewModel.cocktail else { return }
        cocktailNameLabel.text = cocktail.name
        glassTypeLabel.text = cocktail.glass
        instructionsTextView.text = cocktail.instruction
        if let imageURL = cocktail.imageURL {
            self.cocktailImageView.fetchImage(using: imageURL)
        }
        self.ingredientTableView.reloadData()
    }
} // end of class

extension CocktailDetailViewController: CocktailDetailViewModeldelegate {
    func cocktailLoadedSuccessfully() {
        updateViews()
    }
}

// MARK: - Tableview data source and delegate conformance.
extension CocktailDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cocktailDetailViewModel.cocktail?.measuredIngredients.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath) as? IngredientTableViewCell,
              let measuredIngredient = cocktailDetailViewModel.cocktail?.measuredIngredients[indexPath.row]
        else { return UITableViewCell() }
        cell.updateViews(measuredIngredient: measuredIngredient)
        return cell
    }
}
