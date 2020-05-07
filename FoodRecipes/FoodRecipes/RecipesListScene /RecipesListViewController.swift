//
//  ViewController.swift
//  FoodRecipes
//
//  Created by Ana on 17/03/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

final class RecipesListViewController: UIViewController {
  
  private var mainView: RecipesListView!
  private var network: NetworkManager!
  private var modelData: RecipeModel!
  
  required init(withModel model: RecipeModel) {
    super.init(nibName: nil, bundle: nil)
    modelData = model
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    mainView = RecipesListView(delegate: self)
    view = mainView
  }
  
  override func viewDidLoad() {
    mainView.updateRecipeData(modelData)
  }
}


// MARK: - RecipesListDelegate
extension RecipesListViewController: RecipesListDelegate {
  
  func pushViewController(model: Hit) {
    let nextViewController = IngredientsListViewController(withModel: model.recipe)
    navigationController?.pushViewController(nextViewController, animated: true)
  }
}
