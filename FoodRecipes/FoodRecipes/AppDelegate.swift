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
    
    setupBaseViewController()
    return true
  }
}


private extension AppDelegate {
  
  func setupBaseViewController() {
    window = UIWindow(frame: UIScreen.main.bounds)
    let viewController = FilterRecipeViewController()
    let navigation = UINavigationController(rootViewController: viewController)
    window?.rootViewController = navigation
    window?.makeKeyAndVisible()
  }
}
