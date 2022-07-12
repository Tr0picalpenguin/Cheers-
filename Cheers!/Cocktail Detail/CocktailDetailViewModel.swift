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
   
    
    init(delegate: CocktailDetailViewModeldelegate, cocktailResult: CocktailDetail) {
        self.delegate = delegate
        self.cocktail = cocktailResult
    }
    
    // property to recieve the cocktail details
    
    // need to work out 2 different fetch operations. One will be from the network API and the other will be from the custom firestore
    
    
}// end of class
