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
    
    func updateViews(with customCocktail: CustomCocktail) {
        favoritesNameLabel.text = customCocktail.cocktailName
        
    }
} // end of class




