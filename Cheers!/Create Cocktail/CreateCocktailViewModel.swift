//
//  CreateCocktailViewModel.swift
//  Cheers!
//
//  Created by Scott Cox on 7/5/22.
//

import Foundation
import UIKit

class CreateCocktailViewModel {
    
    var cocktail: CustomCocktail?
    private let service: FirebaseSyncable
    
    init(cocktail: CustomCocktail? = nil, firebaseService: FirebaseSyncable = FirebaseService()) {
        self.cocktail = cocktail
        self.service = firebaseService
    }
    
    
    // MARK: - CRUD
    func createCocktail(with cocktailName: String, glass: String, instruction: String, collectionType: String, uuid: String = UUID().uuidString, image: UIImage, ingredient1: String, ingredient2: String, ingredient3: String, ingredient4: String, ingredient5: String, ingredient6: String, ingredient7: String, ingredient8: String, ingredient9: String, ingredient10: String, ingredient11: String, ingredient12: String, ingredient13: String, ingredient14: String, ingredient15: String, measurement1: String, measurement2: String, measurement3: String, measurement4: String, measurement5: String, measurement6: String, measurement7: String, measurement8: String, measurement9: String, measurement10: String, measurement11: String, measurement12: String,measurement13: String,measurement14: String,measurement15: String) {
       
        guard let cocktail = cocktail else { return }
        cocktail.cocktailName = cocktailName
        cocktail.glass = glass
        cocktail.instruction = instruction
        cocktail.uuid = uuid
        cocktail.ingredient1 = ingredient1
        cocktail.ingredient2 = ingredient2
        cocktail.ingredient3 = ingredient3
        cocktail.ingredient4 = ingredient4
        cocktail.ingredient5 = ingredient5
        cocktail.ingredient6 = ingredient6
        cocktail.ingredient7 = ingredient7
        cocktail.ingredient8 = ingredient8
        cocktail.ingredient9 = ingredient9
        cocktail.ingredient10 = ingredient10
        cocktail.ingredient11 = ingredient11
        cocktail.ingredient12 = ingredient12
        cocktail.ingredient13 = ingredient13
        cocktail.ingredient14 = ingredient14
        cocktail.ingredient15 = ingredient15
        cocktail.measurement1 = measurement1
        cocktail.measurement2 = measurement2
        cocktail.measurement3 = measurement3
        cocktail.measurement4 = measurement4
        cocktail.measurement5 = measurement5
        cocktail.measurement6 = measurement6
        cocktail.measurement7 = measurement7
        cocktail.measurement8 = measurement8
        cocktail.measurement9 = measurement9
        cocktail.measurement10 = measurement10
        cocktail.measurement11 = measurement11
        cocktail.measurement12 = measurement12
        cocktail.measurement13 = measurement13
        cocktail.measurement14 = measurement14
        cocktail.measurement15 = measurement15
       
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

