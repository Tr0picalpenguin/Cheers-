//
//  CocktailListTableViewCell.swift
//  Cheers!
//
//  Created by Scott Cox on 7/5/22.
//

import UIKit
import AVFoundation
import SwiftUI

class CocktailListTableViewCell: UITableViewCell {

    @IBOutlet weak var cocktailImageView: UIImageView!
    @IBOutlet weak var cocktailNameLabel: UILabel!
    
    var cocktailImage: UIImage?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cocktailImageView.image = nil
    }
    
   
    func fetchImage(for cocktail: Cocktail) {
        guard let imageString = cocktail.imageURL else { return }
        NetworkController.fetchImage(with: imageString) { result in
            switch result {
            case.success(let cocktailImage):
                DispatchQueue.main.async {
                    self.cocktailImageView.image = cocktailImage
                    self.cocktailImage = cocktailImage
                }
            case .failure(let error):
                print("Error", error.localizedDescription)
            }
        }
    }
    
    
    func updateViews(with cocktail: Cocktail) {
        cocktailNameLabel.text = cocktail.name
        fetchImage(for: cocktail)
    }
} // end of class

