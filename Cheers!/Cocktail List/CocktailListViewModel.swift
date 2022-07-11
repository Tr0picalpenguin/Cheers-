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
    
    var topLevelDictionary: TopLevelDictionary?
    // is this right?
    var standardCocktails: [Cocktail] = []
    var customCocktails: [Cocktail] = []
    private weak var delegate: CocktailListViewModelDelegate?
    
    init(delegate: CocktailListViewModelDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - CRUD
   
    func loadData() {
        fetchApiCocktailList { result in
            switch result {
            case .success(let cocktail):
                DispatchQueue.main.async {
                    self.standardCocktails = cocktail
                    self.delegate?.cocktailsLoadedSuccessfully()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //  function that fetches the cocktail list and decodes from the API
    func fetchApiCocktailList(completion: @escaping (Result<[Cocktail], NetworkError>) -> Void) {
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v2/9973533/popular.php") else {
            completion(.failure(.badURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(.requestError(error)))
            }
            guard let data = data else {
                completion(.failure(.couldNotUnwrap))
                return
            }
            do {
                let topLevelDictionary = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                completion(.success(topLevelDictionary.drinks))
            } catch {
                completion(.failure(.errorDecoding(error)))
            }
        }.resume()
    }
    
    //function that updates the views from Firebase storage
    func fetchCustomCocktailList() {
        
    }
    
}
