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
    var ingredients: [CustomIngredient]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let alertController = UIAlertController(title: "Create your own cocktail feature coming soon!", message: "Click ok and get back to enjoying a full database of curated cocktail. Cheers!", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(confirmAction)
        self.present(alertController, animated: true, completion: nil)
        return
    }
 
    @objc private func showAlert() {
        let alert = UIAlertController(title: "Add ingredient", message: "Please input the ingredient and measurement you want to add to the cocktail.", preferredStyle: .alert)
        
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
        guard let cocktailName = cocktailNameTextField.text?.capitalized,
              let glass = glassTypeTextField.text?.capitalized,
              let instructions = instructionsTextView.text,
 //             let ingredients = ingredients,
              let cocktailImage = cocktailImageView.image else { return }
        
        viewModel.createCocktail(with: cocktailName, glass: glass, instruction: instructions, image: cocktailImage)
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
