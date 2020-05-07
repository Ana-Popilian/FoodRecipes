//
//  UILabel+Additions.swift
//  FoodRecipes
//
//  Created by Ana on 28/04/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

extension UILabel {
  
  convenience init(text: String?, font: UIFont, textAlignment: NSTextAlignment, textColor: UIColor) {
    self.init()
    self.text = text
    self.textColor = textColor
    self.font = font
    self.textAlignment = textAlignment
  }
}
