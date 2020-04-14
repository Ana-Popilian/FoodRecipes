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
  private var modelData: Recipe!
  
  required init(withModel model: Recipe) {
    super.init(nibName: nil, bundle: nil)
    modelData = model
  }
  
  //swiftlint:disable unavailable_function
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    navigationItem.title = "List of ingredients"
    
    mainView = IngredientsListView(delegate: self)
    view = mainView
  }
  
  override func viewDidLoad() {
    
    mainView.updateIngredientsData(modelData.ingredientLines)
    mainView.updateImageView(modelData.image)
    mainView.updateTitleLabel(modelData.label)
  }
}

extension IngredientsListViewController: IngredientsListDelegate {
  
}
