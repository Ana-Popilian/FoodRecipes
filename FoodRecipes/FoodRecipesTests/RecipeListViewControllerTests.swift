//
//  RecipeListViewController.swift
//  FoodRecipesTests
//
//  Created by Ana Popilian on 20/05/2021.
//  Copyright © 2021 Ana Popilian. All rights reserved.
//

import XCTest
import UIKit
@testable import FoodRecipes

final class RecipeListViewControllerTests: XCTestCase {
   
   private var sut: RecipesListViewController!
   private let mainView = RecipeListViewMock()
   private let recipeMockModel = RecipeModel(recipe: [Recipe(recipeDetails: RecipeDetails(label: "Test", image: URL(string: "Test")!, url: "Test", ingredientLines: ["test1", "test2"], calories: 2))])
   
   override func setUp() {
      sut = RecipesListViewController(withModel: recipeMockModel, mainView: mainView)
   }
   
   func testNavigationBarTintColorHasChanged() {
      let navigation = UINavigationController(rootViewController: sut)
      
      XCTAssertFalse(navigation.navigationBar.barTintColor == ColorHelper.customWhite)
     
      sut.loadView()
      XCTAssertTrue(navigation.navigationBar.barTintColor == ColorHelper.customWhite)
   }
   
   func testUpdateRecipeDataCalledAtLoad() {
      XCTAssertFalse(mainView.isUpdateRecipeCalled)
      sut.viewDidLoad()
      
      XCTAssertTrue(mainView.isUpdateRecipeCalled)
   }
   
   func testNavigationBarHiden() {
      let navigation = UINavigationController(rootViewController: sut)
      navigation.setNavigationBarHidden(true, animated: false)
      
      sut.viewWillAppear(false)
      XCTAssertFalse(navigation.isNavigationBarHidden)
   }
   
   func testPushViewController() {
      let navigation = NavigationControllerMock(rootViewController: sut)
      navigation.expectation = expectation(description: "pushViewControllerExpectation")
      let counter = navigation.viewControllers.count
      sut.pushViewController(model: recipeMockModel.recipe.first!)
      
      wait(for: [navigation.expectation!], timeout: 2)
      let afterPushCounter = navigation.viewControllers.count
      XCTAssertNotEqual(counter, afterPushCounter)
   }
}


final class RecipeListViewMock: UIView, RecipesListViewProtocol {
   var delegate: RecipesListDelegate?
   var isUpdateRecipeCalled = false
   
   func updateRecipeData(_ data: RecipeModel) {
      isUpdateRecipeCalled = true
   }
}


final class NavigationControllerMock: UINavigationController {
   var expectation: XCTestExpectation?
   
   override func pushViewController(_ viewController: UIViewController, animated: Bool) {
      super.pushViewController(viewController, animated: false)
      expectation?.fulfill()
   }
}
