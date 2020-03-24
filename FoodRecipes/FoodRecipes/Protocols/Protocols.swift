//
//  Protocols.swift
//  FoodRecipes
//
//  Created by Ana on 18/03/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import Foundation

protocol Identifiable {
  
  static var identifier: String { get }
}

extension Identifiable {
  
  static var identifier: String {
    return String(describing: self)
  }
}
