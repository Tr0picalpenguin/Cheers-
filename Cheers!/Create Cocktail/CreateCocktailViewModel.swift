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
    func createCocktail(with cocktailName: String, glass: String, instruction: String, collectionType: String, uuid: String = UUID().uuidString, image: UIImage) {
       
        guard let cocktail = cocktail else { return }
        cocktail.cocktailName = cocktailName
        cocktail.glass = glass
        cocktail.instruction = instruction
        cocktail.uuid = uuid
       
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

