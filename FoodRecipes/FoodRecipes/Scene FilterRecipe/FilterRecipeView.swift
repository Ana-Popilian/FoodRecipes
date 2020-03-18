//
//  FilterRecipeView.swift
//  FoodRecipes
//
//  Created by Ana on 18/03/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

final class FilterRecipeView: UIView {
  
    private var searchBar: UISearchBar!
    private var collectionView: UITableView!
    
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
  }


  // MARK: - Private Zone
  private extension FilterRecipeView {
    
    func setupSearchBar() {
      searchBar = UISearchBar()
      searchBar.placeholder = " Search recipe by ingredient"
      searchBar.isTranslucent = false
    }
  }
