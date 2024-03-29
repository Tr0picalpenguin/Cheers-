//
//  CreateCocktailViewController.swift
//  Cheers!
//
//  Created by Scott Cox on 7/5/22.
//

import UIKit

class CreateCocktailViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var cocktailNameTextField: UITextField!
    @IBOutlet weak var glassTypeTextField: UITextField!
    @IBOutlet weak var instructionsTextView: TextView!
    
    @IBOutlet weak var ingredientsTableView: UITableView!
    
    
    @IBOutlet weak var cocktailImageView: UIImageView!
    
    var viewModel: CreateCocktailViewModel!
    var ingredients: [CustomIngredient]? = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
        viewModel = CreateCocktailViewModel()
        addTapGesture()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
        cocktailImageView.image = UIImage(systemName: "camera.fill")
        cocktailNameTextField.text = nil
        glassTypeTextField.text = nil
//        instructionsTextView.text = "Enter instructions..."
//        instructionsTextView.textColor = UIColor.lightGray
//        instructionsTextView.delegate = self
        instructionsTextView.textColor = .darkGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ingredientsTableView.dataSource = self
    
    }
    
    func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if instructionsTextView.textColor == UIColor.lightGray {
//            instructionsTextView.text = nil
//            // MARK: - Need to establish if user is using dark mode or not to change text color
//            instructionsTextView.textColor = UIColor.systemGray
//            instructionsTextView.alpha = 1
//        }
//    }
//
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if textView.text.isEmpty {
//            textView.text = "Enter instructions..."
//            textView.textColor = UIColor.lightGray
//            textView.alpha = 0.50
//        }
//    }
    
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
        if cocktailNameTextField.text?.isEmpty == true {
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
            
            // create a reset views function that resets all the views.
            // I dont know if this refreshVC code is right
            ingredients?.removeAll()
            refreshVC(sender: CreateCocktailViewController.self)
            
            cocktailSaved()
            
//            loadTabBarController(atIndex: 2)
            
            // MARK: - Need to instantiate the "my creations" tab when the save button is tapped or maybe go straight to the finished detail view. But thats a slide to dismiss view and I need to figure out where I want the user to end up.
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
    func cocktailSaved() {
        let storyboard = UIStoryboard(name: "TabController", bundle: nil)
        guard let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarName") as? UITabBarController else { return }
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(viewController: tabBarController)
    }
//    private func loadTabBarController(atIndex: Int){
//        self.tabBarIndex = atIndex
//        self.performSegue(withIdentifier: "showTabBar", sender: self)
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "showTabBar" {
//            let tabBarController = segue.destination as! UITabBarController
//            tabBarController.selectedIndex = self.tabBarIndex
//        }
//    }
    
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

class TextView: UITextView {

    // MARK: - Properties
    private let placeholderLabel = UILabel()
    var placeholder: String = "Enter text here..." {
        didSet {
            placeholderLabel.text = placeholder
        }
    }
    var placeholderColor: UIColor = .gray {
        didSet {
            placeholderLabel.textColor = placeholderColor
        }
    }

    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        delegate = self

        placeholderLabel.text = placeholder
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.font = self.font
        placeholderLabel.numberOfLines = 0
        addSubview(placeholderLabel)
    }

    // MARK: - Functions
    override func layoutSubviews() {
        super.layoutSubviews()

        placeholderLabel.frame = CGRect(x: textContainerInset.left + textContainer.lineFragmentPadding,
                                        y: textContainerInset.top,
                                        width: bounds.width - textContainerInset.left - textContainerInset.right - textContainer.lineFragmentPadding * 2,
                                        height: bounds.height - textContainerInset.top - textContainerInset.bottom)
        placeholderLabel.sizeToFit()
    }

    private func updatePlaceholder() {
        placeholderLabel.isHidden = !text.isEmpty
    }
}

// MARK: - UITextViewDelegate
extension TextView: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        updatePlaceholder()
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        placeholderLabel.isHidden = true
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        updatePlaceholder()
    }
}
