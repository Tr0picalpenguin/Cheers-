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
    

    // is this right?
    var standardCocktails: [Cocktail] = []
    var standardCocktailDetail: [CocktailDetail] = []

    private weak var delegate: CocktailListViewModelDelegate?
    
    init(delegate: CocktailListViewModelDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - CRUD
   // in the load data I need an if else statement for which segment on the segmented control I am on to call the appropriate function.
    func loadData() {
        
        fetchPopularApiCocktailList { result in
            switch result {
            case .success(let drink):
                DispatchQueue.main.async {
                    self.standardCocktails = drink
                    self.delegate?.cocktailsLoadedSuccessfully()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //  function that fetches the popular cocktail list and decodes from the API
    func fetchPopularApiCocktailList(completion: @escaping (Result<[Cocktail], NetworkError>) -> Void) {
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
    func fetchFullApiCocktailList(completion: @escaping (Result<[Cocktail], NetworkError>) -> Void) {
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
        
    }
    
}
