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
    func signInWithApple(token: String, nonce: String)
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
        reference.collection(CustomCocktail.CocktailKeys.collectionType).getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(.fireBaseError(error)))
            }
            guard let data = snapshot?.documents else {
                completion(.failure(.noDataFound))
                return
            }
            let customCocktailsArray = data.compactMap({ $0.data() })
            let cocktails = customCocktailsArray.compactMap({ CustomCocktail(dictionary: $0)})
            completion(.success(cocktails))
        }
    }
    
    func deleteCocktail(cocktail: CustomCocktail) {
        reference.collection(CustomCocktail.CocktailKeys.collectionType).document(cocktail.uuid).delete()
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
        storage.child("images").child(cocktail.uuid).getData(maxSize: 1024 * 1024) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    completion(.failure(.failedToUnwrapData))
                    return
                }
                completion(.success(image))
            case .failure(let error):
                completion(.failure(.fireBaseError(error)))
            }
        }
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
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            switch authResult {
            case .some:
                UserDefaults.standard.bool(forKey: email)
                completion(.success(true))
            case .none:
                if let error = error {
                    completion(.failure(.fireBaseError(error)))
                }
            }
        }

    }
    
    func logoutUser() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
    
    // TODO: - add a closure. result type with bool
    func signInWithApple(token: String, nonce: String) {
        // Initialize a Firebase credential.
        let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                  idToken: token,
                                                  rawNonce: nonce)
        // Sign in with Firebase.
        Auth.auth().signIn(with: credential) { (authResult, error) in
          if let error = error {
            // Error. If error.code == .MissingOrInvalidNonce, make sure
            // you're sending the SHA256-hashed nonce as a hex string with
            // your request to Apple.
            print(error.localizedDescription)
            return
          }
          print("Made it this far.")
          // ...
        }
    }
    
} // end of struct
