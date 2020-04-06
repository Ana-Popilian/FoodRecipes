//
//  ImageFetcher.swift
//  FoodRecipes
//
//  Created by Ana on 30/03/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import Foundation

final class ImageFetcher: NSObject {
  
    func fetchImage(imageUrl: URL, completion: @escaping (Data?) -> Void) {
      
      let request = URLRequest(url: imageUrl)
      let sessionConfig = URLSessionConfiguration.default
      sessionConfig.timeoutIntervalForResource = 8
      
      let session = URLSession(configuration: sessionConfig)
      
      let task = session.dataTask(with: request, completionHandler: { data, _, _ in
        completion(data)
      })
      task.resume()
    }
  }
