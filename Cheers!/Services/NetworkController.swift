//
//  NetworkController.swift
//  Cheers!
//
//  Created by Scott Cox on 7/10/22.
//

import Foundation
import UIKit.UIImage
import UIKit

class NetworkController {
    
    private static let baseURLString = "www.thecocktaildb.com/api/json/v2/9973533"
    private static let popularComponent = "popular.php"
    
    static func fetchCocktailList(with url: URL, completion: @escaping (Result<TopLevelDictionary, NetworkError>) -> Void) {
        
        // set up the url
        guard let url = URL(string: baseURLString) else {
            completion(.failure(.badURL))
            return
        }
        let popularURL = url.appendingPathComponent(popularComponent)
        print(popularURL)
        
        URLSession.shared.dataTask(with: popularURL) { cocktailListData, _, error in
            if let error = error {
                print("There was an error fetching the data. The url is \(popularURL), the error is \(error.localizedDescription)")
                completion(.failure(.badURL))
            }
            guard let cocktailListData = cocktailListData else {
                completion(.failure(.couldNotUnwrap))
                return
            }
            do {
                let cocktailList = try JSONDecoder().decode(TopLevelDictionary.self, from: cocktailListData)
                completion(.success(cocktailList))
            } catch {
                print("Error!", error.localizedDescription)
                completion(.failure(.errorDecoding(error)))
            }
        }.resume()
    }
    
    static func fetchCocktail(with urlString: String, completion: @escaping (Result<Cocktail, NetworkError>) -> Void) {
        guard let cocktailURL = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: cocktailURL) { cocktailData, _, error in
            if let error = error {
                print("Encountered error: \(error.localizedDescription)")
                completion(.failure(.badURL))
            }
            guard let cocktailData = cocktailData else {
                completion(.failure(.couldNotUnwrap))
                return
            }
            do {
                let cocktail = try JSONDecoder().decode(Cocktail.self, from: cocktailData)
                completion(.success(cocktail))
            } catch {
                print("Encountered error when decoding the data:", error.localizedDescription)
                completion(.failure(.errorDecoding(error)))
            }
        }.resume()
    }
    
    static func fetchImage(with imageString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        guard let imageURL = URL(string: imageString) else {
            completion(.failure(.badURL))
            return
        }
        URLSession.shared.dataTask(with: imageURL) { imageData, _, error in
            if let error = error {
                print("Encountered error; \(error.localizedDescription)")
                completion(.failure(.badURL))
            }
            guard let imageData = imageData else {
                completion(.failure(.couldNotUnwrap))
                return
            }
            do {
                let image = try JSONDecoder().decode(, from: <#T##Data#>)
            } catch {
                
            }

        }
    }
 
}// end of class
