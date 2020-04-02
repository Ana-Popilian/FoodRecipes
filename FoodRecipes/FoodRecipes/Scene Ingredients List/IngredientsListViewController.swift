//
//  IngredientsListViewController.swift
//  FoodRecipes
//
//  Created by Ana on 31/03/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

class IngredientsListViewController: UIViewController {
  
  private var mainView: IngredientsListView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "Ingredients list"
    
    mainView = IngredientsListView(delegate: self)
    view = mainView
  }
}

extension IngredientsListViewController: IngredientsListDelegate {
  
}
