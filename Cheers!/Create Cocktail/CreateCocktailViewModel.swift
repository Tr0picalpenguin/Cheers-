//
//  CreateCocktailViewModel.swift
//  Cheers!
//
//  Created by Scott Cox on 7/5/22.
//

import Foundation
import UIKit

class CreateCocktailViewModel {
    
    
    let name1 = "old fashioned"
    let description1 = "this is a really good drink"
    let glass1 = "tumbler"
    let ingredients1 = UITableView()
    let image1 = "image"
    let uuid1 = "uuid"
    
    
    
    // MARK: - CRUD
    func createCocktail(with name:String, description: String, ingredients: UITableView, glass: String, uuid: String = UUID().uuidString, imageURL: String = "") {
        let cocktail = Cocktail(name: name1, description: description1, ingredients: ingredients1, glass: glass1, uuid: uuid1, imageURL: image1)
        CocktailListViewModel.sharedInstance.cocktails.append(cocktail)

    }
}
