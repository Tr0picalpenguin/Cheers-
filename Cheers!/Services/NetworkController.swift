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
    
 //   private static let baseURLString = "https://www.thecocktaildb.com/api/json/v2/9973533/filter.php?a=Alcoholic"
 //   private static let popularComponent = "filter.php?a=Alcoholic" // This will change to the full list component once I hear back from the guys that manage the API.
    
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
    
    static func fetchCocktail(with urlString: String, completion: @escaping (Result<CocktailDetail, NetworkError>) -> Void) {
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
                let cocktail = try JSONDecoder().decode(CocktailDetail.self, from: cocktailData)
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
