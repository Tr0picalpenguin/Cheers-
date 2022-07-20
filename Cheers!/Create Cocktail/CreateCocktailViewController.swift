//
//  CreateCocktailViewController.swift
//  Cheers!
//
//  Created by Scott Cox on 7/5/22.
//

import UIKit

class CreateCocktailViewController: UIViewController {

    @IBOutlet weak var cocktailNameTextField: UITextField!
    @IBOutlet weak var glassTypeTextField: UITextField!
    @IBOutlet weak var instructionsTextView: UITextView!
    
// I need to figure out how to do the outlets for the custom cells
    @IBOutlet weak var cocktailImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc private func showAlert() {
        let alert = UIAlertController(title: "Add ingredeient", message: "Please input the ingredient and measurement you want to add to the cocktail.", preferredStyle: .alert)
        
        alert.addTextField { field in
            field.placeholder = "Ingredient..."
            field.returnKeyType = .next
        }
        
        alert.addTextField { field in
            field.placeholder = "Measurement..."
            field.returnKeyType = .continue
            
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { _ in
            guard let fields = alert.textFields, fields.count == 2 else { return }
            let ingredientField = fields[0]
            let measurementField = fields[1]
            guard let ingredient = ingredientField.text, !ingredient.isEmpty,
                  let measurement = measurementField.text, !measurement.isEmpty else { return }
        }))
        present(alert, animated: true)
    }
    
    
    @IBAction func addIngredientButtonTapped(_ sender: Any) {
       showAlert()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
    }
    
   
}
