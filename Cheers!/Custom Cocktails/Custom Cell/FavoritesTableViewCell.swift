//
//  FavoritesTableViewCell.swift
//  Cheers!
//
//  Created by Scott Cox on 7/18/22.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var favoritesImageView: UIImageView!
    @IBOutlet weak var favoritesNameLabel: UILabel!
    
    var cocktailImage: UIImage?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        favoritesImageView.image = nil
    }
    
   
//    func fetchImage(for cocktail: CustomCocktail) {
//        guard let imageString = cocktail.imageURL else { return }
//        NetworkController.fetchImage(with: imageString) { result in
//            switch result {
//            case.success(let cocktailImage):
//                DispatchQueue.main.async {
//                    self.favoritesImageView.image = cocktailImage
//                    self.cocktailImage = cocktailImage
//                }
//            case .failure(let error):
//                print("Error", error.localizedDescription)
//            }
//        }
//    }
    
    func updateViews(with cocktail: CustomCocktail) {
        favoritesNameLabel.text = cocktail.cocktailName
//       fetchImage(for: cocktail)
    }
} // end of class




