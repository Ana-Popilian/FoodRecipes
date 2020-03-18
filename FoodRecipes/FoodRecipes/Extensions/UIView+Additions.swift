//
//  UIView+Additions.swift
//  FoodRecipes
//
//  Created by Ana on 18/03/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

extension UIView {
  
  func addSubviewWithoutConstr(_ subview: UIView) {
    subview.translatesAutoresizingMaskIntoConstraints = false
    addSubview(subview)
  }
}
