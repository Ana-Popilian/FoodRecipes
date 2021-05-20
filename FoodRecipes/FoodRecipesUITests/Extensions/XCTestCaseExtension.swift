//
//  XCTestCaseExtension.swift
//  FoodRecipesUITests
//
//  Created by Ana Popilian on 20/05/2021.
//  Copyright © 2021 Ana Popilian. All rights reserved.
//


import XCTest

extension XCTestCase {
   
   func wait(forElement element: XCUIElement, timeout: TimeInterval) {
      
      let predicate = NSPredicate(format: "exists == true")
      
      //This will make the test runner continuously evaluate the predicate and wait until it matches
      let expectation = expectation(for: predicate, evaluatedWith: element)
      wait(for: [expectation], timeout: timeout)
   }
}
