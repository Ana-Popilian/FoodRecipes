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
    return allSatisfy({ $0.isWhitespace })
  }
  
  func trimTrailingPunctuation() -> String {
    return self.trimmingCharacters(in: .whitespacesAndNewlines)
      .trimmingCharacters(in: .punctuationCharacters)
      .trimmingCharacters(in: .whitespacesAndNewlines)
  }
}
