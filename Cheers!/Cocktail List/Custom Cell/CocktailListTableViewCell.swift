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
                }
            case .failure(let error):
                print("Error", error.localizedDescription)
            }
        }
    }
    
    func updateViews(with cocktail: Cocktail) {
        cocktailNameLabel.text = cocktail.name
        // need to call the fetch image function that was created above.
        fetchImage(for: cocktail)
    }

    
} // end of class

