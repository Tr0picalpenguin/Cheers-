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
    
    let mocktail = CustomCocktail(cocktailName: "Mocktail", glass: "yes", instruction: "Make the drink", collectionType: "Collection?", ingredient1: "Whiskey", ingredient2: "Vodka", ingredient3: "Gin", ingredient4: "Rum", ingredient5: "Malk", ingredient6: "red", ingredient7: "Yelloe", ingredient8: "8", ingredient9: "9", ingredient10: "10", ingredient11: "10", ingredient12: "10", ingredient13: "10", ingredient14: "10", ingredient15: "10", measurement1: "1oz", measurement2: "2oz", measurement3: "3oz", measurement4: "4oz", measurement5: "5oz", measurement6: "6oz", measurement7: "7oz", measurement8: "7oz", measurement9: "7oz", measurement10: "7oz", measurement11: "7oz", measurement12: "7oz", measurement13: "7oz", measurement14: "7oz", measurement15: "7oz")
    var mockArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
     tryThis()
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
//        tryThis()
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


extension CocktailDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tryThis() {
        
            if mocktail.ingredient1 != nil {
                mockArray.append(mocktail.ingredient1!)
            } else if mocktail.ingredient2 != nil {
                mockArray.append(mocktail.ingredient2!)
            }else if mocktail.ingredient3 != nil {
                mockArray.append(mocktail.ingredient3!)
            }else if mocktail.ingredient4 != nil {
                mockArray.append(mocktail.ingredient4!)
            }else if mocktail.ingredient5 != nil {
                mockArray.append(mocktail.ingredient5!)
            }else if mocktail.ingredient6 != nil {
                mockArray.append(mocktail.ingredient6!)
            }else if mocktail.ingredient7 != nil {
                mockArray.append(mocktail.ingredient7!)
            }else if mocktail.ingredient8 != nil {
                mockArray.append(mocktail.ingredient8!)
            }else if mocktail.ingredient9 != nil {
                mockArray.append(mocktail.ingredient9!)
            }else if mocktail.ingredient10 != nil {
                mockArray.append(mocktail.ingredient10!)
            }else if mocktail.ingredient11 != nil {
                mockArray.append(mocktail.ingredient11!)
            }else if mocktail.ingredient12 != nil {
                mockArray.append(mocktail.ingredient12!)
            }else if mocktail.ingredient13 != nil {
                mockArray.append(mocktail.ingredient13!)
            }else if mocktail.ingredient14 != nil {
                mockArray.append(mocktail.ingredient14!)
            } else if mocktail.ingredient15 != nil {
                mockArray.append(mocktail.ingredient15!)
            }
        ingredientsTableView.reloadData()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(mockArray.count)
        return mockArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
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

