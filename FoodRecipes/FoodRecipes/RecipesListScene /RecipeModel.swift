//
//  RecipeModel.swift
//  FoodRecipes
//
//  Created by Ana on 24/03/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import Foundation


struct RecipeModel: Codable {
  
  let recipe: [Recipe]
    
    private enum CodingKeys: String, CodingKey {
        case recipe = "hits"
    }
}

struct Recipe: Codable {
    
  let recipeDetails: RecipeDetails
    
    private enum CodingKeys: String, CodingKey {
        case recipeDetails = "recipe"
    }
}

struct RecipeDetails: Codable {
  let label: String
  let image: URL
  let url: String
  let ingredientLines: [String]
  let calories: Double
}
