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
  private var dietaryHeaderLabel: UILabel!
  private var dietFilterCollectionView: UICollectionView!
  private var healthRestrictionLabel: UILabel!
  private var healthFilterCollectionView: UICollectionView!
  private var searchRecipesButton: UIButton!
  private weak var delegate: FilterRecipeDelegate?
  
  private var dietaryFilters = ["balanced", "high-protein", "low-fat", "low-carb"]
  private var healthFilters: Array = ["peanut-free", "tree-nut-free", "alcohol-free", "vegetarian", "vegan", "sugar-conscious"]
  
  
  required init(delegate: FilterRecipeDelegate?) {
    super.init(frame: .zero)
    self.delegate = delegate
    
    setupSearchBar()
    setupDietaryHeaderLabel()
    setupDietFilterCollectionView()
    setupHealthRestrictionLabel()
    setupHealthFilterCollectionView()
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
  
  func setupDietaryHeaderLabel() {
    dietaryHeaderLabel = UILabel()
    dietaryHeaderLabel.text = "Dietary Restictions"
    dietaryHeaderLabel.textAlignment = .center
    dietaryHeaderLabel.textColor = .black
    dietaryHeaderLabel.font = UIFont.boldSystemFont(ofSize: 16)
  }
  
  func setupDietFilterCollectionView() {
    dietFilterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    dietFilterCollectionView.dataSource = self
    dietFilterCollectionView.delegate = self
    dietFilterCollectionView.isScrollEnabled = false
    dietFilterCollectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.identifier)
    dietFilterCollectionView.backgroundColor = .systemPurple
  }
  func setupHealthFilterCollectionView() {
    healthFilterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    healthFilterCollectionView.dataSource = self
    healthFilterCollectionView.delegate = self
    healthFilterCollectionView.isScrollEnabled = false
    healthFilterCollectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.identifier)
    healthFilterCollectionView.backgroundColor = .systemPink
  }
  
  func setupHealthRestrictionLabel() {
    healthRestrictionLabel = UILabel()
    healthRestrictionLabel.text = "Health Restictions"
    healthRestrictionLabel.textAlignment = .center
    healthRestrictionLabel.textColor = .black
    healthRestrictionLabel.font = UIFont.boldSystemFont(ofSize: 16)
  }
  
  func setupSearchRecipesButton() {
    searchRecipesButton = UIButton()
    searchRecipesButton.setTitle("Search recipes", for: .normal)
    searchRecipesButton.layer.cornerRadius = 18
    searchRecipesButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    searchRecipesButton.backgroundColor = .blue
  }
  
  @objc func buttonPressed() {
    
  }
}


//MARK : - UICollectionViewDelegateFlowLayout
extension FilterRecipeView: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //    let width = (frame.width / 3 - 14)
    return CGSize(width: 175, height: 60)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
  }
}


//MARK: - UICollectionViewDataSource
extension FilterRecipeView: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if collectionView == dietFilterCollectionView {
      return dietaryFilters.count
    }
    
    return healthFilters.count
  }
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    if collectionView == dietFilterCollectionView {
      let cellA = dietFilterCollectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.identifier, for: indexPath) as! FilterCollectionViewCell
      
      return cellA
    }
      
    else {
      let cellB = healthFilterCollectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.identifier, for: indexPath) as! FilterCollectionViewCell
      
      return cellB
    }
  }
}


//MARK: - UIcollectionViewDelegate
extension FilterRecipeView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //implement later
  }
}


// MARK: - Constraints Zone
private extension FilterRecipeView {
  
  func addSubViews() {
    addSubviewWithoutConstr(searchBar)
    addSubviewWithoutConstr(dietaryHeaderLabel)
    addSubviewWithoutConstr(dietFilterCollectionView)
    addSubviewWithoutConstr(healthRestrictionLabel)
    addSubviewWithoutConstr(healthFilterCollectionView)
    addSubviewWithoutConstr(searchRecipesButton)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      
      dietaryHeaderLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5),
      dietaryHeaderLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      dietaryHeaderLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      dietFilterCollectionView.topAnchor.constraint(equalTo: dietaryHeaderLabel.bottomAnchor, constant: 5),
      dietFilterCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      dietFilterCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      dietFilterCollectionView.heightAnchor.constraint(equalToConstant: 150),
      
      healthRestrictionLabel.topAnchor.constraint(equalTo: dietFilterCollectionView.bottomAnchor, constant: 5),
      healthRestrictionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      healthRestrictionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      healthFilterCollectionView.topAnchor.constraint(equalTo: healthRestrictionLabel.bottomAnchor, constant: 5),
      healthFilterCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      healthFilterCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      searchRecipesButton.topAnchor.constraint(equalTo: healthFilterCollectionView.bottomAnchor, constant: 15),
      searchRecipesButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35),
      searchRecipesButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35),
      searchRecipesButton.heightAnchor.constraint(equalToConstant: 45),
      searchRecipesButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
    ])
  }
}
