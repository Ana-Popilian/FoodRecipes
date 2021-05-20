//
//  FoodRecipesUITests.swift
//  FoodRecipesUITests
//
//  Created by Ana Popilian on 20/05/2021.
//  Copyright © 2021 Ana Popilian. All rights reserved.
//

import XCTest

final class FoodRecipesUITests: XCTestCase {
   
   var app: XCUIApplication!
   
   override func setUp() {
      super.setUp()
      
      continueAfterFailure = false
      app = XCUIApplication()
      app.launch()
   }

   func testSearchRecipesButtonDisabled() {
      app.searchBar.tap()
      app.searchBar.typeText("egg")
      app.keyboards.buttons["search"].tap()
      XCTAssertFalse(app.searchRecipesButton.isEnabled)
   }
   
   func testSearchRecipesButtonEnabled() {
      app.searchBar.tap()
      app.searchBar.typeText("egg")
      app.keyboards.buttons["search"].tap()
      app.filterCollectionViewCell.firstMatch.tap()
      XCTAssertTrue(app.searchRecipesButton.isEnabled)
   }
   
   func testRecipesListTableViewCellElements() {
      app.searchBar.tap()
      app.searchBar.typeText("egg")
      app.keyboards.buttons["search"].tap()
      app.filterCollectionViewCell.firstMatch.tap()
      app.searchRecipesButton.tap()
      wait(forElement: app.recipeListNameLabel, timeout: 5)
      wait(forElement: app.recipeListCaloriesLabel, timeout: 5)
   }
   
   func testListOfIngredients() {
      app.searchBar.tap()
      app.searchBar.typeText("egg")
      app.keyboards.buttons["search"].tap()
      app.filterCollectionViewCell.firstMatch.tap()
      app.searchRecipesButton.tap()
      app.recipeListTableViewCell.firstMatch.tap()
      wait(forElement: app.ingredientsRecipeTitle, timeout: 5)
      wait(forElement: app.ingredientsListLabel, timeout: 5)
      wait(forElement: app.ingredientsListImageView, timeout: 5)
   }
   
   func testShowDirectionWebView() {
      app.searchBar.tap()
      app.searchBar.typeText("egg")
      app.keyboards.buttons["search"].tap()
      app.filterCollectionViewCell.firstMatch.tap()
      app.searchRecipesButton.tap()
      app.recipeListTableViewCell.firstMatch.tap()
      app.seeDirectionsButton.tap()
      wait(forElement: app.recipeDirectionsWebView, timeout: 6)
   }
}


// MARK: - XCUIApplication extension
private extension XCUIApplication {
   var searchRecipesButton: XCUIElement { self.buttons["search-recipes"] }
   var searchBar: XCUIElement { self.otherElements["search-bar-by-ingredient"] }
   var filterCollectionViewCell: XCUIElement { self.collectionViews.cells["filter-collection-view-cell"] }
   
   var recipeListTableView: XCUIElement { self.tables["recipe-list-table-view"] }
   var recipeListTableViewCell: XCUIElement { self.cells["recipe-list-table-view-cell"] }
   var recipeListNameLabel: XCUIElement { self.staticTexts["recipe-list-name-label"] }
   var recipeListCaloriesLabel: XCUIElement { self.staticTexts["recipe-list-calories"] }
   
   var ingredientsRecipeTitle: XCUIElement { self.otherElements.staticTexts["ingredients-recipe-title"] }
   var ingredientsListLabel: XCUIElement { self.tables.cells.staticTexts["ingredient-list-label"] }
   var ingredientsListImageView: XCUIElement { self.otherElements.images["ingredients-recipe-image"] }
   var seeDirectionsButton: XCUIElement { self.buttons["see-directions-button"] }
  
   var recipeDirectionsWebView: XCUIElement { self.webViews["recipe-directions-web-view"] }
}
