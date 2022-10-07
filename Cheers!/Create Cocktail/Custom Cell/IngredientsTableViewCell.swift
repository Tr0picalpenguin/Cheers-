//
//  IngredientsTableViewCell.swift
//  Cheers!
//
//  Created by Scott Cox on 10/4/22.
//

import UIKit

class IngredientsTableViewCell: UITableViewCell {

    @IBOutlet weak var ingredientTextLabel: UILabel!
    @IBOutlet weak var measurementTextLabel: UILabel!
    
    func updateViews(ingredient: CustomIngredient) {
        ingredientTextLabel.text = ingredient.ingredient
        measurementTextLabel.text = ingredient.measurement
    }
}
