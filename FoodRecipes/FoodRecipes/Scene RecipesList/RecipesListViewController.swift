//
//  ViewController.swift
//  FoodRecipes
//
//  Created by Ana on 17/03/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

class RecipesListViewController: UIViewController {

  private var mainView: RecipesListView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    mainView = RecipesListView(delegate: self)
    view = mainView
    view.backgroundColor = .yellow
  }
}


extension RecipesListViewController: RecipesListDelegate {  
}
