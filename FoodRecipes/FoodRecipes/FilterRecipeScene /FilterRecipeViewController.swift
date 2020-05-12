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
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    navigationController?.setNavigationBarHidden(true, animated: false)
  }
}


// MARK: - FilterRecipeDelegate
extension FilterRecipeViewController: FilterRecipeDelegate {
  
  func didSelectedSearchRecipes(withDetails details: RecipeData) {
    let networkManager = NetworkManager()
    networkManager.getRecipes(ingr: details.ingredient,
                              diet: details.dietRestr,
                              healths: details.healthRestr,
                              completionHandler: { [weak self] (model) in
                                
                                guard let self = self else {
                                  return }
                                
                                DispatchQueue.main.async {
                                  let nextViewController = RecipesListViewController(withModel: model)
                                  self.navigationController?.pushViewController(nextViewController, animated: true)
                                }
                                
    })
  }
}
