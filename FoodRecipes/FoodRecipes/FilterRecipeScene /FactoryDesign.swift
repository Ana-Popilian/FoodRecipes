//
//  FactoryDesign.swift
//  FoodRecipes
//
//  Created by Ana Popilian on 16/12/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

protocol RecipeListViewControllerProtocol where Self: UIViewController { }

protocol InjectorProtocol {
   func makeNetworkManager() -> NetworkManagerProtocol
   func makeRecipeListViewController(withModel: RecipeModel) -> RecipeListViewControllerProtocol
}

struct AppInjector: InjectorProtocol {
   private init() {}
   
   static let shared = AppInjector()
}


// MARK: - InjectorProtocolExtension
extension InjectorProtocol {
   func makeNetworkManager() -> NetworkManagerProtocol {
      NetworkManager()
   }
   
   func makeRecipeListViewController(withModel: RecipeModel) -> RecipeListViewControllerProtocol {
      RecipesListViewController(withModel: withModel, mainView: RecipesListView())
   }
}
