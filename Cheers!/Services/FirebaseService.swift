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


protocol FirebaseSyncable {
    func saveCocktail(_ cocktail: CustomCocktail, with image: UIImage)
    func loadCocktails(completion: @escaping(Result<[CustomCocktail], FirebaseError>) -> Void)
    func deleteCocktail(cocktail: CustomCocktail)
    func updateCocktail(with cocktail: CustomCocktail)
    func saveImage(_ image: UIImage, to cocktail: CustomCocktail, completion: @escaping() -> Void)
    func fetchImage(from cocktail: CustomCocktail, completion: @escaping (Result<UIImage, FirebaseError>) -> Void)
    func createUser(with email: String, password: String, completion: @escaping (Result<Bool, FirebaseError>) -> Void)
    func loginUser(with email: String, password: String, completion: @escaping (Result<Bool, FirebaseError>) -> Void)
    func logoutUser()
    func deleteUser()
    func signInWithApple(token: String, nonce: String)
}

struct FirebaseService: FirebaseSyncable {
    
    
    let reference = Firestore.firestore()
    let storage = Storage.storage().reference()
    
    func saveCocktail(_ cocktail: CustomCocktail, with image: UIImage) {
        reference.collection(CustomCocktail.CocktailKeys.collectionType).document(cocktail.uuid)
            .setData(cocktail.cocktailData)
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
            let cocktails = customCocktailsArray.compactMap({ CustomCocktail(from: $0)})
            completion(.success(cocktails))
        }
    }
    
    func deleteCocktail(cocktail: CustomCocktail) {
        reference.collection(CustomCocktail.CocktailKeys.collectionType).document(cocktail.uuid).delete()
    }
    
    func updateCocktail(with cocktail: CustomCocktail) {
        reference.collection(CustomCocktail.CocktailKeys.collectionType).document(cocktail.uuid).updateData(cocktail.cocktailData)
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
                UserDefaults.standard.set(authResult.user.email, forKey: "email")
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
            case .some(let result):
                let id = result.user.uid
                let email = result.user.email
                UserDefaults.standard.set(id, forKey: "userID")
                UserDefaults.standard.set(email, forKey: "email")
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
          print("Error signing out.", signOutError)
        }
    }
    
    func deleteUser() {
        let user = Auth.auth().currentUser

        user?.delete { error in
          if let error = error {
              print(error.localizedDescription)
          } else {
              
            // Account deleted.
          }
        }
        
    }
    
    // TODO: - add a closure. result type with bool
    func signInWithApple(token: String, nonce: String) {
        let credentials = OAuthProvider.credential(withProviderID: "apple.com", idToken: token, rawNonce: nonce)
        Auth.auth().signIn(with: credentials) { authResult, error in
            let ID = authResult?.user.uid
            let email = authResult?.user.email
            UserDefaults.standard.set(ID, forKey: "userID")
            UserDefaults.standard.set(email, forKey: "email")
            if let error = error {
                print(error.localizedDescription)
                return
          }
            let storyboard = UIStoryboard(name: "TabController", bundle: nil)
                    guard let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarName") as? UITabBarController else { return }
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(viewController: tabBarController)
         
        }
    }
    
} // end of struct
