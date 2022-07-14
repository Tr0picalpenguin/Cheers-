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
    func saveCocktail(_ cocktail: CustomCocktail, with image: UIImage)
    func loadCocktails(completion: @escaping(Result<[CustomCocktail], FirebaseError>) -> Void)
    func deleteCocktail(cocktail: CustomCocktail)
    func saveImage(_ image: UIImage, to cocktail: CustomCocktail, completion: @escaping() -> Void)
    func fetchImage(from cocktail: CustomCocktail, completion: @escaping (Result<UIImage, FirebaseError>) -> Void)
    func createUser(with email: String, password: String, completion: @escaping (Result<Bool, FirebaseError>) -> Void)
    func loginUser(with email: String, password: String, completion: @escaping (Result<Bool, FirebaseError>) -> Void)
    func logoutUser()
}

struct FirebaseService: FirebaseSyncable {
    
    
    
    let reference = Firestore.firestore()
    let storage = Storage.storage().reference()
    
    func saveCocktail(_ cocktail: CustomCocktail, with image: UIImage) {
        saveImage(image, to: cocktail) {
            reference.collection(CustomCocktail.CocktailKeys.collectionType).document(cocktail.uuid)
                .setData(cocktail.cocktailData)
                }
            }
    
    func loadCocktails(completion: @escaping (Result<[CustomCocktail], FirebaseError>) -> Void) {
        
    }
    
    func deleteCocktail(cocktail: CustomCocktail) {
        
    }

    func saveImage(_ image: UIImage, to cocktail: CustomCocktail, completion: @escaping () -> Void) {
        guard let imageData = image.pngData() else { return }
        storage.child("images").child(cocktail.uuid).putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print(error.localizedDescription)
                completion()
                return
            }
            self.storage.child("images").child(cocktail.uuid).downloadURL { url, error in
                if let error = error {
                    print(error.localizedDescription)
                    completion()
                    return
                }
                guard let url = url else { return }
                cocktail.imageURL = url
                completion()
            }
        }
    }

    func fetchImage(from cocktail: CustomCocktail, completion: @escaping (Result<UIImage, FirebaseError>) -> Void) {
        <#code#>
    }
    
    func createUser(with email: String, password: String, completion: @escaping (Result<Bool, FirebaseError>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            switch authResult {
            case .some(let authResult):
                UserDefaults.standard.set(authResult.user.uid, forKey: "uuid")
                completion(.success(true))
            case .none:
                if let error = error {
                    completion(.failure(.fireBaseError(error)))
                }
            }
        }
    }
    
    func loginUser(with email: String, password: String, completion: @escaping (Result<Bool, FirebaseError>) -> Void) {
        

    }
    
    func logoutUser() {
        
    }
    
    
    
} // end of struct
