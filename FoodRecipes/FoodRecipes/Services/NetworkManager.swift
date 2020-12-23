//
//  NetworkManager.swift
//  FoodRecipes
//
//  Created by Ana on 24/03/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

protocol NetworkManagerProtocol {
    func getRecipes(ingr: String, diet: String?, healths: [String], completionHandler: @escaping ( Result <RecipeModel, Error>) -> Void)
}

enum DataError: Error {
    case invalidResponse
    case invalidData
    case decodingError
    case serverError
}

final class NetworkManager: NetworkManagerProtocol {
    
    func getRecipes(ingr: String, diet: String?, healths: [String], completionHandler: @escaping (Result <RecipeModel, Error>) -> Void) {
        
        var urlString = "https://api.edamam.com/search?q=\(ingr)&app_id=a23ceb61&app_key=4ae1251cbb5c580cdef496445cd67bbf&from=0&to=100&calories=591-722"
        
        if let diet = diet {
            urlString.append("&diet=\(diet)")
        }
        
        for health in healths {
            urlString.append("&health=\(health)")
        }
        
        guard let url = URL(string: urlString) else {
            fatalError("url must be valid!!!")
        }
        
        let request = URLSession.shared.dataTask(with: url) {(data, response, error) in
            if let error = error {
                completionHandler(.failure(error))
            }
            
            guard let response = response as? HTTPURLResponse else {
                completionHandler(.failure(DataError.invalidResponse))
                return
            }
            
            if 200 ... 299 ~= response.statusCode {
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(RecipeModel.self, from: data)
                        completionHandler(.success(response))
                    }
                    catch {
                        completionHandler(.failure(DataError.decodingError))
                    }
                } else {
                    completionHandler(.failure(DataError.invalidData))
                }
            } else {
                completionHandler(.failure(DataError.serverError))
            }
        }
        request.resume()
    }
}

