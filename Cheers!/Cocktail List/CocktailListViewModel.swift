//
//  CocktailListViewModel.swift
//  Cheers!
//
//  Created by Scott Cox on 7/5/22.
//

import Foundation

protocol CocktailListViewModelDelegate: AnyObject {
    func cocktailsLoadedSuccessfully()
}


class CocktailListViewModel {
    
//    private let service: FirebaseSyncable?
    // is this right?
    var standardCocktails: [Cocktail] = []
    var customCocktails: [CustomCocktail] = []

    private weak var delegate: CocktailListViewModelDelegate?
    private var service: FirebaseSyncable
    
    init(delegate: CocktailListViewModelDelegate, firebaseService: FirebaseSyncable = FirebaseService()) {
        self.delegate = delegate
        self.service = firebaseService
    }
    
    // MARK: - CRUD
   
    func loadData() {
        fetchPopularApiCocktailList()
    }
    
    func logout() {
        service.logoutUser()
        UserDefaults.standard.removeObject(forKey: "email")
      
    }
    
    //  function that fetches the popular cocktail list and decodes from the API
    func fetchPopularApiCocktailList() {
        let popularURL = URL(string: "https://www.thecocktaildb.com/api/json/v2/9973533/popular.php")
        NetworkController.fetchCocktailList(with: popularURL!) { result in
            switch result {
            case .success(let popularDict):
                DispatchQueue.main.async {
                    self.standardCocktails = popularDict.drinks
                    self.delegate?.cocktailsLoadedSuccessfully()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //  function that fetches the full cocktail list and decodes from the API
    func fetchFullApiCocktailList() {
        let fullListURL = URL(string: "https://www.thecocktaildb.com/api/json/v2/9973533/filter.php?a=Alcoholic")
        NetworkController.fetchCocktailList(with: fullListURL!) { result in
            switch result {
            case.success(let fullDict):
                DispatchQueue.main.async {
                    self.standardCocktails = fullDict.drinks
                    self.delegate?.cocktailsLoadedSuccessfully()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //function that updates the views from Firebase storage
    func fetchCustomCocktailList() {
        service.loadCocktails { result in
            switch result {
            case .success(let customCocktails):
                self.customCocktails = customCocktails
                self.delegate?.cocktailsLoadedSuccessfully()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
