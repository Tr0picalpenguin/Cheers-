//
//  CocktailDetailViewModel.swift
//  Cheers!
//
//  Created by Scott Cox on 7/5/22.
//

import Foundation

protocol CocktailDetailViewModeldelegate: AnyObject {
    func cocktailLoadedSuccessfully()
}

class CocktailDetailViewModel {
    
    private weak var delegate: CocktailDetailViewModeldelegate?
    
    var cocktail: CocktailDetail?
    
    
//    var ingredientsArray: [String?] = [cocktail?.ingredient1, cocktail?.ingredient2, cocktail?.ingredient3, cocktail?.ingredient4, cocktail?.ingredient5, cocktail?.ingredient6, cocktail?.ingredient7, cocktail?.ingredient8, cocktail?.ingredient9, cocktail?.ingredient10, cocktail?.ingredient11, cocktail?.ingredient12, cocktail?.ingredient13, cocktail?.ingredient14, cocktail?.ingredient15]
//
//    {
//        var ingredients: [String?] = []
//        for ingredient in cocktail where !ingredientsArray.contains(nil) {
//            ingredients.append(ingredient)
//        }
//        return ingredients
//
//    }
    
    init(delegate: CocktailDetailViewModeldelegate) {
        self.delegate = delegate
        
    }
    
    func fetchCocktailDetail(with cocktailID: String) {
       
        NetworkController.fetchCocktailDetail(with: cocktailID) { result in
            switch result {
            case .success(let cocktailDetail):
                DispatchQueue.main.async {
                    self.cocktail = cocktailDetail
                    self.delegate?.cocktailLoadedSuccessfully()
                }
            case.failure(let error):
                print(error)
            }
        }
    }
    
    func ingredientArray(cocktail: CocktailDetail) {
        
    }
}// end of class
