//
//  CustomButton.swift
//  FoodRecipes
//
//  Created by Ana on 30/03/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

final class CustomButton: UIButton {
  
  override var isEnabled: Bool {
    didSet {
      backgroundColor = isEnabled ? ColorHelper.customRed : .systemGray
    }
  }
}
