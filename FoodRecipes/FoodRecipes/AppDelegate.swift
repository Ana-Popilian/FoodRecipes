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

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    let viewController = RecipesListViewController()
       window?.rootViewController = viewController
       window?.makeKeyAndVisible()
    
    return true
  }
}

