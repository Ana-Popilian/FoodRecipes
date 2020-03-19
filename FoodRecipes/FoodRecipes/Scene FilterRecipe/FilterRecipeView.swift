//
//  FilterRecipeView.swift
//  FoodRecipes
//
//  Created by Ana on 18/03/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

protocol FilterRecipeDelegate: UIViewController {
}

final class FilterRecipeView: UIView {
  
  
  private var searchBar: UISearchBar!
  private var filterCollectionView: UICollectionView!
  private var searchRecipesButton: UIButton!
  private weak var delegate: FilterRecipeDelegate?
  
  required init(delegate: FilterRecipeDelegate?) {
     super.init(frame: .zero)
     self.delegate = delegate
    
    setupSearchBar()
    setupFilterCollectionView()
    setupSearchRecipesButton()
    
    addSubViews()
    setupConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


// MARK: - Private Zone
private extension FilterRecipeView {
  
  func setupSearchBar() {
    searchBar = UISearchBar()
    searchBar.placeholder = "Search recipe by ingredient"
    searchBar.isTranslucent = false
  }
  
  func setupFilterCollectionView() {
   filterCollectionView = UICollectionView()
    let layout = FilterCollectionViewLayout()
    filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    filterCollectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.identifier)
    filterCollectionView.backgroundColor = .systemPurple
  }
  
  func setupSearchRecipesButton() {
    searchRecipesButton = UIButton()
    searchRecipesButton.setTitle("Search recipes", for: .normal)
    searchRecipesButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    searchRecipesButton.backgroundColor = .blue
  }
  
  @objc func buttonPressed() {
    
  }
}


// MARK: - Constraints Zone
private extension FilterRecipeView {
  
  func addSubViews() {
    addSubviewWithoutConstr(searchBar)
    addSubviewWithoutConstr(filterCollectionView)
    addSubviewWithoutConstr(searchRecipesButton)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      
      filterCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
      filterCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      filterCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      searchRecipesButton.topAnchor.constraint(equalTo: filterCollectionView.bottomAnchor, constant: 10),
      searchRecipesButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      searchRecipesButton.centerYAnchor.constraint(equalTo: centerYAnchor),
      searchRecipesButton.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}
