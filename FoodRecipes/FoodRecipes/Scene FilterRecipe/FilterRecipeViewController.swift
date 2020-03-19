//
//  FilterRecipeViewController.swift
//  FoodRecipes
//
//  Created by Ana on 18/03/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

class FilterRecipeViewController: UIViewController {

  private var mainView: FilterRecipeView!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    mainView = FilterRecipeView(delegate: self)
    view = mainView
    view.backgroundColor = .yellow
  }
}


extension FilterRecipeViewController: FilterRecipeDelegate {
  
}
