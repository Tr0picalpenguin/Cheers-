//
//  FavoritesViewModel.swift
//  Cheers!
//
//  Created by Scott Cox on 7/7/22.
//

import Foundation

protocol FavoritesViewModeldelegate: AnyObject {
    func cocktailLoadedSuccessfully()
}

class FavoritesViewModel {
    
    var favoriteCocktail: CocktailDetail?
    var customCocktail: CustomCocktail?
    
   
    private weak var delegate: FavoritesViewModeldelegate?
    private var service: FirebaseSyncable
    
    init(delegate: FavoritesViewModeldelegate, firebaseService: FirebaseSyncable = FirebaseService()) {
        self.delegate = delegate
        self.service = firebaseService
    }
    
    
    func fetchfavorites(with cocktailID: String) {
        NetworkController.fetchCocktailDetail(with: cocktailID) { result in
            switch result {
            case .success(let cocktail):
                DispatchQueue.main.async {
                    self.favoriteCocktail = cocktail
                    self.delegate?.cocktailLoadedSuccessfully()
                }
            case .failure(let error):
                print(error)
            }
        
        }
    }
    
    
}
