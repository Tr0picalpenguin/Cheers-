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
    
    @IBOutlet weak var firstIngredientLabel: UILabel!
    @IBOutlet weak var firstMeasurementLabel: UILabel!
    @IBOutlet weak var secondIngredientLabel: UILabel!
    @IBOutlet weak var secondMeasurementLabel: UILabel!
    @IBOutlet weak var thirdIngredientLabel: UILabel!
    @IBOutlet weak var thirdMeasurementLabel: UILabel!
    @IBOutlet weak var fourthIngredientLabel: UILabel!
    @IBOutlet weak var fourthMeasurementLabel: UILabel!
    @IBOutlet weak var fifthIngredientLabel: UILabel!
    @IBOutlet weak var fifthMeasurementLabel: UILabel!
    @IBOutlet weak var sixthIngredientLabel: UILabel!
    @IBOutlet weak var sixthMeasurementLabel: UILabel!
    @IBOutlet weak var seventhIngredientLabel: UILabel!
    @IBOutlet weak var seventhMeasurementLabel: UILabel!
    @IBOutlet weak var eighthIngredientLabel: UILabel!
    @IBOutlet weak var eighthMeasurementLabel: UILabel!
    @IBOutlet weak var ninthIngredientLabel: UILabel!
    @IBOutlet weak var ninthMeasurementLabel: UILabel!
    @IBOutlet weak var tenthIngredientLabel: UILabel!
    @IBOutlet weak var tenthMeasurementLabel: UILabel!
    @IBOutlet weak var eleventhIngredientLabel: UILabel!
    @IBOutlet weak var eleventhMeasurementLabel: UILabel!
    @IBOutlet weak var twelthIngredientLabel: UILabel!
    @IBOutlet weak var twelthMeasuremantLabel: UILabel!
    @IBOutlet weak var thirteenthIngredientLabel: UILabel!
    @IBOutlet weak var thirteenthMeasurementLabel: UILabel!
    @IBOutlet weak var fourteenthIngredientLabel: UILabel!
    @IBOutlet weak var fourteenthMeasurementLabel: UILabel!
    @IBOutlet weak var fifteenthIngredientLabel: UILabel!
    @IBOutlet weak var fifteenthMeasurementLabel: UILabel!
    
    
    var cocktailDetailViewModel: CocktailDetailViewModel!
    var cocktail: [CocktailDetail] = []
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    func updateViews() {
        guard let cocktail = cocktailDetailViewModel.cocktail else { return }
        if let imageURL = cocktail.imageURL {
            self.cocktailImageView.fetchImage(using: imageURL)
        }
        self.cocktailNameLabel.text = cocktail.name.capitalized
        self.glassTypeLabel.text = cocktail.glass
        self.intstructionsTextView.text = cocktail.instruction
        self.firstIngredientLabel.text = cocktail.ingredient1
        self.firstMeasurementLabel.text = cocktail.measurement1
        
        self.secondIngredientLabel.text = cocktail.ingredient2
        self.secondMeasurementLabel.text = cocktail.measurement2
        
        self.thirdIngredientLabel.text = cocktail.ingredient3
        self.thirdMeasurementLabel.text = cocktail.measurement3
        
        self.fourthIngredientLabel.text = cocktail.ingredient4
        self.fourthMeasurementLabel.text = cocktail.measurement4
        
        self.fifthIngredientLabel.text = cocktail.ingredient5
        self.fifthMeasurementLabel.text = cocktail.measurement5
        
        self.sixthIngredientLabel.text = cocktail.ingredient6
        self.sixthMeasurementLabel.text = cocktail.measurement6
        
        self.seventhIngredientLabel.text = cocktail.ingredient7
        self.seventhMeasurementLabel.text = cocktail.measurement7
        
        self.eighthIngredientLabel.text = cocktail.ingredient8
        self.eighthMeasurementLabel.text = cocktail.measurement8
        
        self.ninthIngredientLabel.text = cocktail.ingredient9
        self.ninthMeasurementLabel.text = cocktail.measurement9
        
        self.tenthIngredientLabel.text = cocktail.ingredient10
        self.tenthMeasurementLabel.text = cocktail.measurement10
        
        self.eleventhIngredientLabel.text = cocktail.ingredient11
        self.eleventhMeasurementLabel.text = cocktail.measurement11
        
        self.twelthIngredientLabel.text = cocktail.ingredient12
        self.twelthMeasuremantLabel.text = cocktail.measurement12
        
        self.thirteenthIngredientLabel.text = cocktail.ingredient13
        self.thirteenthMeasurementLabel.text = cocktail.measurement13
        
        self.fourteenthIngredientLabel.text = cocktail.ingredient14
        self.fourteenthMeasurementLabel.text = cocktail.measurement14
        
        self.fifteenthIngredientLabel.text = cocktail.ingredient15
        self.fifteenthMeasurementLabel.text = cocktail.measurement15
    }
    
   
    var defaultLikes: Int = 0
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        let currentLikes = defaultLikes + 1
        let likes: String = "\(currentLikes) Likes"
        likesLabel.text = likes
        defaultLikes = currentLikes
    }
    
    @IBAction func favoritesButtonTapped(_ sender: Any) {
        
    }
    
} // end of class

extension CocktailDetailViewController: CocktailDetailViewModeldelegate {
    func cocktailLoadedSuccessfully() {
        updateViews()
    }
}



// TODO: - need to populate the detail table view witht the list of ingredients.
//extension CocktailDetailViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//
//
//    }
//
//
//}

