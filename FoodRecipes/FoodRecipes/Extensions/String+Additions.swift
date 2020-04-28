//
//  StringExtension.swift
//  FoodRecipes
//
//  Created by Ana on 30/03/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import Foundation

extension String {
  
  var isBlank: Bool {
    allSatisfy { $0.isWhitespace }
  }
}
