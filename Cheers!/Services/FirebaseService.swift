//
//  FirebaseService.swift
//  Cheers!
//
//  Created by Scott Cox on 7/8/22.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth
// Need to add FirebaseStorage

protocol FirebaseSyncable {
    func saveCocktail(_ cocktail: CustomCocktail)
    func loadCocktails(completion: @escaping(Result<[CustomCocktail], FirebaseError>) -> Void)
    func deleteCocktail(cocktail: CustomCocktail)
    func loginUser()
    func logoutUser()
}

struct FirebaseService: FirebaseSyncable {
    func saveCocktail(_ cocktail: CustomCocktail) {
        <#code#>
    }
    
    func loadCocktails(completion: @escaping (Result<[CustomCocktail], FirebaseError>) -> Void) {
        <#code#>
    }
    
    func deleteCocktail(cocktail: CustomCocktail) {
        <#code#>
    }
    
    func loginUser() {
       
    }
    
    func logoutUser() {
        <#code#>
    }
    
    
    
}
