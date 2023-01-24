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
    
    @IBOutlet weak var ingredientsTableView: UITableView!
    
    
    @IBOutlet weak var cocktailImageView: UIImageView!
    
    var viewModel: CreateCocktailViewModel!
    var ingredients: [CustomIngredient]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
        viewModel = CreateCocktailViewModel()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
        cocktailImageView.image = UIImage(systemName: "camera.fill")
        cocktailNameTextField.text = nil
        glassTypeTextField.text = nil
        instructionsTextView.text = "Enter instructions..."
        instructionsTextView.textColor = UIColor.lightGray
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ingredientsTableView.dataSource = self
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if instructionsTextView.textColor == UIColor.lightGray {
            instructionsTextView.text = nil
            instructionsTextView.textColor = UIColor.black
        }
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
            let customIngredient = CustomIngredient(ingredient: ingredient, measurement: measurement)
            self.ingredients?.append(customIngredient)
            self.ingredientsTableView.reloadData()
        }))
        present(alert, animated: true)
        
    }
    
    
    @IBAction func addIngredientButtonTapped(_ sender: Any) {
        showAlert()
        
    }
    
    // MARK: - Save Button
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if cocktailNameTextField.text?.isEmpty == true && instructionsTextView.text == "Enter instructions..." {
            let alertController = UIAlertController(title: "Required fields missing!", message: "Please fill in remaining fields for your Cocktail Creation", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(confirmAction)
            self.present(alertController, animated: true, completion: nil)
            
            
        } else {
            guard let cocktailName = cocktailNameTextField.text?.capitalized,
                  let glass = glassTypeTextField.text?.capitalized,
                  let instructions = instructionsTextView.text,
                  let ingredientsArray = ingredients,
                  let cocktailImage = cocktailImageView.image else { return }
            
            self.viewModel.createCocktail(with: cocktailName, numberOfLikes: 0, glass: glass, instruction: instructions, image: cocktailImage, ingredients: ingredientsArray)
            
            // MARK: - Need to instantiate the "my creations" tab when the save button is tapped or maybe go straight to the finished detail view. But thats a slide to dismiss view and I need to figure out where I want the user to end up.
            
            //            loadTabBarController(atIndex: 2)
            
            // create a reset views function that resets all the views.
            // I dont know if this refreshVC code is right
            ingredients?.removeAll()
            refreshVC(sender: CreateCocktailViewController.self)
        }
    }
    
    func refreshView() -> () {
        // Calling the viewDidLoad and viewWillAppear methods to "refresh" the VC and run through the code within the methods themselves
        self.viewDidLoad()
        self.viewWillAppear(true)
        self.ingredientsTableView.reloadData()
    }
    
    func refreshVC(sender: AnyObject) {
        self.refreshView()
    }
    
    var tabBarIndex: Int = 2
    
    //function that will trigger the **MODAL** segue
    private func loadTabBarController(atIndex: Int){
        self.tabBarIndex = atIndex
        self.performSegue(withIdentifier: "showTabBar", sender: self)
    }
    
    //in here you set the index of the destination tab and you are done
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showTabBar" {
            let tabBarController = segue.destination as! UITabBarController
            tabBarController.selectedIndex = self.tabBarIndex
        }
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


// MARK: - Tableview datasource methods
extension CreateCocktailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let ingredients = ingredients else { return 0 }
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customIngredientCell", for: indexPath) as? IngredientsTableViewCell else { return UITableViewCell() }
        
        guard let ingredient = ingredients?[indexPath.row] else { return UITableViewCell() }
        
        cell.updateViews(ingredient: ingredient)
        return cell
    }
    
}
