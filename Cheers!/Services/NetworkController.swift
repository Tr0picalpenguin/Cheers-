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
    
    private static let baseDetailURLString = "https://www.thecocktaildb.com/api/json/v2/9973533/lookup.php"
    private static let cocktailIDKey = "i"
    
    static func fetchCocktailList(with url: URL, completion: @escaping (Result<TopLevelDictionary, NetworkError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { cocktailListData, _, error in
            if let error = error {
                print("There was an error fetching the data. The url is \(url), the error is \(error.localizedDescription)")
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
    
    
    static func fetchCocktailDetail(with cocktailID: String, completion: @escaping (Result<CocktailDetail, NetworkError>) -> Void) {
        guard let cocktailDetailURL = URL(string: baseDetailURLString) else {
            completion(.failure(.badURL))
            return
        }
        var urlComponents = URLComponents(url: cocktailDetailURL, resolvingAgainstBaseURL: true)
        let cocktailIdQuery = URLQueryItem(name: cocktailIDKey, value: cocktailID)
        urlComponents?.queryItems = [cocktailIdQuery]
        
        guard let finalDetailURL = urlComponents?.url else { return }
        print(finalDetailURL)
        
        URLSession.shared.dataTask(with: finalDetailURL) { cocktailData, _, error in
            if let error = error {
                print("Encountered error: \(error.localizedDescription)")
                completion(.failure(.badURL))
            }
            guard let cocktailData = cocktailData else {
                completion(.failure(.couldNotUnwrap))
                return
            }
            do {
                let drinks = try JSONDecoder().decode(CoctailDetailTopLevelDictionary.self, from: cocktailData)
                guard let cocktail = drinks.drinks.first else {
                    completion(.failure(.couldNotUnwrap))
                    return
                }
                
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
            guard let image = UIImage(data: imageData) else {
                completion(.failure(.errorDecoding(error!)))
                return
            }
            completion(.success(image))
        }.resume()
    }
}// end of class
