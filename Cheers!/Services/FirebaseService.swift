//
//  FirebaseService.swift
//  Cheers!
//
//  Created by Scott Cox on 7/8/22.
//

import Foundation
import UIKit
import FirebaseFirestore
// need to add FirebaseStorage


protocol FirebaseSyncable {
    func saveCustomCocktail(_ cocktail: Cocktail, with image: UIImage)
    func loadCustomCocktail(completion: @escaping (Result<[Cocktail], FirebaseError>) -> Void)
    func deleteCustomCocktail(cocktail: Cocktail)
    func saveCustomImage(_ image: UIImage, to cocktail: Cocktail, completion: @escaping() -> Void)
    func fetchCustomImage(from cocktail: Cocktail, completion: @escaping (Result<UIImage, FirebaseError>) -> Void)
    func deleteCustomImage(from cocktail: Cocktail)
}


