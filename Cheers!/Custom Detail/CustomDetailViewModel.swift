//
//  CustomDetailViewModel.swift
//  Cheers!
//
//  Created by Scott Cox on 11/11/22.
//

import Foundation

protocol CustomDetailViewModelDelegate: AnyObject {
    func customCocktailLoadedSuccessfully()
}

class CustomDetailViewModel {
    
    private weak var delegate: CustomDetailViewModelDelegate?
    
    var cocktail: CustomCocktail?
    
    init(delegate: CustomDetailViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchCustomCocktailDetail(with customCocktailID: String) {
        // fetch from firestore
    }
    
}// end of class
