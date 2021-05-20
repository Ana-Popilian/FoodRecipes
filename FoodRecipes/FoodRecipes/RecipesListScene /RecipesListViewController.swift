//
//  ViewController.swift
//  FoodRecipes
//
//  Created by Ana on 17/03/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

final class RecipesListViewController: UIViewController, RecipeListViewControllerProtocol {
   
   private var mainView: RecipesListViewProtocol
   private var model: RecipeModel
   private var network: NetworkManager!
   
   required init(withModel model: RecipeModel, mainView: RecipesListViewProtocol) {
      self.mainView = mainView
      self.model = model
      
      super.init(nibName: nil, bundle: nil)
   }
   
   @available(*, unavailable)
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   override func loadView() {
      mainView.delegate = self
      view = mainView
      
      navigationController?.navigationBar.barTintColor = ColorHelper.customWhite
      navigationController?.navigationBar.tintColor = UIColor.black
   }
   
   override func viewDidLoad() {
      mainView.updateRecipeData(model)
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      navigationController?.setNavigationBarHidden(false, animated: animated)
   }
}


// MARK: - RecipesListDelegate
extension RecipesListViewController: RecipesListDelegate {
   
   func pushViewController(model: Recipe) {
      let nextViewController = IngredientsListViewController(withModel: model.recipeDetails)
      navigationController?.pushViewController(nextViewController, animated: true)
   }
}
