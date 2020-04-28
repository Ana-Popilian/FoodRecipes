//
//  UIImageViewDownload.swift
//  FoodRecipes
//
//  Created by Ana on 30/03/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

extension UIImageView {
  
  func downloadImage(from url: URL, downloadFinishedHandler: (() -> Void)? = nil) {
    let imageFetcher = ImageFetcher()
    imageFetcher.fetchImage(imageUrl: url, completion: { data in
      guard let data = data else {
        DispatchQueue.main.async {
          downloadFinishedHandler?()
        }
        return
      }
      
      let image = UIImage(data: data)
      DispatchQueue.main.async {
        self.image = image
        downloadFinishedHandler?()
      }
    })
  }
}
