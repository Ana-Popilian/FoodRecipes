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
    view.backgroundColor = .systemYellow
  }
}


extension FilterRecipeViewController: FilterRecipeDelegate {
  
  func didSelectedSearchRecipes(withDetails details: RecipeData) {
    let networkManager = NetworkManager()
    networkManager.getRecipes(ingr: details.ingredient,
                              diet: details.dietRestr,
                              healths: details.healthRestr,
                              completionHandler: { [weak self] (model) in
                              
                                DispatchQueue.main.async {
                                  let nextViewController = RecipesListViewController(withModel: model)
                                  self?.navigationController?.pushViewController(nextViewController, animated: true)
                                }

    })
    
    //1 call the request with details
    //2 get and parse details
    //3 show updates on th new screen
  }
}
