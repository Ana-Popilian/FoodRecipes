//
//  FilterRecipeViewControllerTests.swift
//  FoodRecipesTests
//
//  Created by Ana Popilian on 16/12/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//


import UIKit
import XCTest
@testable import FoodRecipes


final class FilterRecipeViewControllerTest: XCTestCase {
    
    private var networkManager: NetworkManagerMock!
    private static let testRecipeModel = makeTestRecipeModel()
    private var injectorPassedData: RecipeModel!
    private var injectorMakeRecipeListExpectation: XCTestExpectation!
    
    private static func makeTestRecipeModel() -> RecipeModel {
        let recipeDetails = RecipeDetails(label: "A", image: URL(string: "B")!, url: "C", ingredientLines: ["A", "B"], calories: 124)
        let details = [Recipe(recipeDetails: recipeDetails)]
        return RecipeModel(recipe: details)
    }
    
    func testSelectedSearchRecipesFailure() {
        let myVC = FilterRecipeViewController(injector: self)
        XCTAssertNil(myVC.error, "Error should be nil")
        networkManager.resultIsSuccess = false
        let details = RecipeData(ingredient: "egg", healthRestr: [], dietRestr: "")
        myVC.didSelectedSearchRecipes(withDetails: details)
        XCTAssertNotNil(myVC.error, "Error should not be nil")
    }
    
    func testSelectedSearchRecipesSuccess() {
        let myVC = FilterRecipeViewController(injector: self)
        injectorMakeRecipeListExpectation = XCTestExpectation(description: "passRecipeData")
        
        XCTAssertNil(myVC.recipeData, "Data should be nil")
        let details = RecipeData(ingredient: "egg", healthRestr: [], dietRestr: "")
        myVC.didSelectedSearchRecipes(withDetails: details)
        XCTAssertNotNil(myVC.recipeData, "Data should not be nil")
        
        wait(for: [injectorMakeRecipeListExpectation], timeout: 0.1)
        XCTAssertEqual(FilterRecipeViewControllerTest.testRecipeModel.recipe.first?.recipeDetails.label, injectorPassedData.recipe.first?.recipeDetails.label)
    }
}


// MARK: - InjectorProtocol
extension FilterRecipeViewControllerTest: InjectorProtocol {
    func makeNetworkManager() -> NetworkManagerProtocol {
        
        networkManager = NetworkManagerMock()
        return networkManager
    }
    
    func makeRecipeListViewController(withModel: RecipeModel) ->
    RecipeListViewControllerProtocol {
        
        injectorPassedData = withModel
        injectorMakeRecipeListExpectation.fulfill()
        return RecipeListViewControllerMock()
    }
    
    
    class NetworkManagerMock: NetworkManagerProtocol {
        var resultIsSuccess = true
        func getRecipes(ingr: String, diet: String?, healths: [String], completionHandler: @escaping (Result <RecipeModel, Error>) -> Void) {
            
            if resultIsSuccess {
                completionHandler(.success(FilterRecipeViewControllerTest.testRecipeModel))
            } else {
                completionHandler(.failure(NSError(domain: "A", code: 1)))
            }
        }
    }
    
    class RecipeListViewControllerMock: UIViewController, RecipeListViewControllerProtocol { }
}
