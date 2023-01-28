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
    
    private var delegate: CustomDetailViewModelDelegate?
    
    private var service: FirebaseSyncable
    
    init(delegate: CustomDetailViewModelDelegate, firebaseService: FirebaseSyncable = FirebaseService()) {
        self.delegate = delegate
        self.service = firebaseService
    }
    
    var cocktail: CustomCocktail?
    
    
    func fetchCustomCocktailDetail(with customCocktailID: String) {
        
    }
    
}// end of class
