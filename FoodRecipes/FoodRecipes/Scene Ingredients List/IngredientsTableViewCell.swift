//
//  IngredientsTableViewCell.swift
//  FoodRecipes
//
//  Created by Ana on 31/03/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

final class IngredientsTableViewCell: UITableViewCell, Identifiable {
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }
  
   @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
