//
//  CreateCocktailViewModel.swift
//  Cheers!
//
//  Created by Scott Cox on 7/5/22.
//

import Foundation
import UIKit

protocol CreateCocktailViewModelDelegate {
    func cocktailCreatedSuccessfully()
}
class CreateCocktailViewModel {
    
    var cocktail: CustomCocktail?
    weak var delegate: CreateUserViewModelDelegate?
    private let service: FirebaseSyncable
    
    init(cocktail: CustomCocktail? = nil, firebaseService: FirebaseSyncable = FirebaseService()) {
        self.cocktail = cocktail
        self.service = firebaseService
    }
    
    
    // MARK: - CRUD
    func createCocktail(with cocktailName: String, glass: String, instruction: String, image: UIImage, ingredients: [CustomIngredient] = []) {
       
        guard let cocktail = cocktail else { return }
        cocktail.cocktailName = cocktailName
        cocktail.glass = glass
        cocktail.instruction = instruction
        cocktail.ingredients = ingredients
        
        self.cocktail = CustomCocktail(cocktailName: cocktailName, glass: glass, instruction: instruction, ingredients: ingredients)
        service.saveCocktail(self.cocktail!, with: image)
        
    }
    
    func getImage(completion: @escaping (UIImage?) -> Void) {
        guard let cocktail = cocktail else { return }
        service.fetchImage(from: cocktail) { result in
            switch result {
            case .success(let image):
                completion(image)
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }

    }
}

