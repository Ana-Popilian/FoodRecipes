//
//  RecipeModel.swift
//  FoodRecipes
//
//  Created by Ana on 24/03/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import Foundation


struct RecipeModel: Codable {
  let hits: [Hit]
}

struct Hit: Codable {
  let recipe: Recipe
}

struct Recipe: Codable {
  let label: String
  let image: URL
  let url: String
  let ingredientLines: [String]
  let calories: Double
}