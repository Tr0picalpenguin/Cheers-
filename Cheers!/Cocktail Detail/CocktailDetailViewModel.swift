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
   
    
    init(delegate: CocktailDetailViewModeldelegate) {
        self.delegate = delegate
    }
    
   // can I create a fetchCocktailDetail function that calls the fetchCocktailDetail from the NewtworkController, then call this function in the prepare for segue?
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
    
}// end of class
