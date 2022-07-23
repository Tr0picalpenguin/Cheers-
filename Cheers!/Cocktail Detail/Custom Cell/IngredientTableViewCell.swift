//
//  IngredientTableViewCell.swift
//  Cheers!
//
//  Created by Scott Cox on 7/20/22.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {

    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var measurementLabel: UILabel!
    
    func updateViews(measuredIngredient: MeasuredIngredient) {
        ingredientLabel.text = measuredIngredient.ingredient
        measurementLabel.text = measuredIngredient.measurement
    }
    
    
    
    
    
}
