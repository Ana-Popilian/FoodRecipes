//
//  NetworkManager.swift
//  FoodRecipes
//
//  Created by Ana on 24/03/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

final class NetworkManager: NSObject {
  
  
  func getRecipes(ingr: String, diet: String?, healths: [String], completionHandler: @escaping (_ recipes: RecipeModel) -> Void) {
    
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
    
    let request = URLSession.shared.dataTask(with: url) { (data, response, error) in
      
      do {
        let decoder = JSONDecoder()
        let response = try decoder.decode(RecipeModel.self, from: data!)
        
        completionHandler(response)
        
      } catch let DecodingError.dataCorrupted(context) {
        print(context)
      } catch let DecodingError.keyNotFound(key, context) {
        print("Key '\(key)' not found:", context.debugDescription)
        print("codingPath:", context.codingPath)
      } catch let DecodingError.valueNotFound(value, context) {
        print("Value '\(value)' not found:", context.debugDescription)
        print("codingPath:", context.codingPath)
      } catch let DecodingError.typeMismatch(type, context) {
        print("Type '\(type)' mismatch:", context.debugDescription)
        print("codingPath:", context.codingPath)
      } catch {
        print("error: ", error)
      }
    }
    request.resume()
  }
}
