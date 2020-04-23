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
}

extension NSRegularExpression {
  func matches(_ string: String) -> Bool {
    let range = NSRange(location: 0, length: string.utf16.count)
    return firstMatch(in: string, options: [], range: range) != nil
  }
}
