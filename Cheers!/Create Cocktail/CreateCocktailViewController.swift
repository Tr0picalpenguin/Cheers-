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
    
  
    
    @IBOutlet weak var cocktailImageView: UIImageView!
    
    var viewModel: CreateCocktailViewModel!
    var cocktail: CustomCocktail?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
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
                  let measurement = measurementField.text, !measurement.isEmpty else {
                print("Invalid entries")
                return
                
            }
        }))
        present(alert, animated: true)
    }
    
    @IBAction func addIngredientButtonTapped(_ sender: Any) {
       showAlert()
        
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
       
    }
    
    @objc func imageViewTapped() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    private func setupImageView() {
        cocktailImageView.contentMode = .scaleAspectFit
        cocktailImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        cocktailImageView.addGestureRecognizer(tapGesture)
    }

}

extension CreateCocktailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        cocktailImageView.image = image
    }
}
