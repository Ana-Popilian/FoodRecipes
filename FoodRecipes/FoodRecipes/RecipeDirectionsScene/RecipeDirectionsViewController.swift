//
//  RecipeDirectionsViewController.swift
//  FoodRecipes
//
//  Created by Ana on 15/04/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

final class RecipeDirectionsViewController: UIViewController {
  
  private var mainView: RecipeDirectionsView!
  
  required init(withUrl url: String) {
    super.init(nibName: nil, bundle: nil)
    mainView = RecipeDirectionsView(withUrl: url)
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    view = mainView
  }
}
