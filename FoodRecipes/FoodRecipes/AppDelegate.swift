//
//  AppDelegate.swift
//  FoodRecipes
//
//  Created by Ana on 17/03/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  // swiftlint:disable discouraged_optional_collection
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
//    let ingredients = ["apa", "faina", "otet", "sare", "sare", "ulei", "branza", "hartie de copt", "soia", "cartofi", "varza", "drojdie", "morcov"]
//    let url = URL(string: "https://www.edamam.com/web-img/fb1/fb1488726ffa0997d8855da3180a4c53.jpg")!
//    let recipe = Recipe(label: "Placinta", image: url, url: "http://www.bbcgoodfood.com/recipes/5799/", ingredientLines: ingredients, calories: 23)
  
    let viewController = FilterRecipeViewController()
    let navigation = UINavigationController(rootViewController: viewController)
    window?.rootViewController = navigation
    window?.makeKeyAndVisible()
    
    return true
  }
}
