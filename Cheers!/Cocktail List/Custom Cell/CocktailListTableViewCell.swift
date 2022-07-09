//
//  CocktailListTableViewCell.swift
//  Cheers!
//
//  Created by Scott Cox on 7/5/22.
//

import UIKit

class CocktailListTableViewCell: UITableViewCell {

    @IBOutlet weak var cocktailImageView: UIImageView!
    @IBOutlet weak var cocktailNameLabel: UILabel!
    
    var cocktail: Cocktail? {
        // didSet is called a property observer. didSet will observe the Cocktail property. So it is looking for when the Cocktail property "is set" or has a value. It is observing for when the property has been assigned. Ex. nametag.
        didSet {
            updateView()
        }
    }
    
    // I need to update the views on the cell.
    func updateView() {
        guard let cocktail = cocktail else { return }
        cocktailNameLabel.text = cocktail.name
        // need to update the image in the cell but this image is coming from a network call
    }

}
