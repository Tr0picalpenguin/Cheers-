//
//  CustomListViewModel.swift
//  Cheers!
//
//  Created by Scott Cox on 11/9/22.
//

import Foundation

protocol CustomListViewModelDelegate{
    func customCocktailsLoadedSuccessfully()
}

class CustomListViewModel {
    
    var customCocktails: [CustomCocktail] = []
    var myCocktails: [CustomCocktail] = []
    
    private var delegate: CustomListViewModelDelegate?
    private var service: FirebaseSyncable
    
    init(delegate: CustomListViewModelDelegate, firebaseService: FirebaseSyncable = FirebaseService()) {
        self.delegate = delegate
        self.service = firebaseService
    }
    
    func loadData() {
        fetchCustomCocktailList()
    }
    
    func fetchMyCustomCocktails() {
        
    }
    
    func fetchCustomCocktailList() {
        service.loadCocktails { result in
            switch result {
            case .success(let customCocktails):
                self.customCocktails = customCocktails
                self.delegate?.customCocktailsLoadedSuccessfully()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchMyCocktails() {
        service.loadMyCocktails { result in
            switch result {
            case .success(let myCocktails):
                self.myCocktails = myCocktails
                self.delegate?.customCocktailsLoadedSuccessfully()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchCustomImage(from customCocktail: CustomCocktail) {
        
    }
    
    
} // end of class
