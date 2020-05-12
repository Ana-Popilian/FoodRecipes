//
//  Protocols.swift
//  FoodRecipes
//
//  Created by Ana on 18/03/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

protocol CellIdentifiable {
  
  static var identifier: String { get }
}

extension CellIdentifiable {
  
  static var identifier: String {
    return String(describing: self)
  }
}


extension UITableViewCell: CellIdentifiable { }

extension UICollectionViewCell: CellIdentifiable { }
