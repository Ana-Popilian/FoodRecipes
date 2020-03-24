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
  
  let dietaryFilters = ["balanced", "high-protein", "low-fat", "low-carb"]
  let healthFilters: Array = ["peanut-free", "tree-nut-free", "alcohol-free", "vegetarian", "vegan", "sugar-conscious"]
  
  private enum VT {
    static let topContraint: CGFloat = 20
    static let dietCollMult: CGFloat = 0.25
    static let searchButtonHeight: CGFloat = 45
    static let searchButtonLead: CGFloat = 35
  }
  
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
  
  @available(*, unavailable)
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
    dietaryHeaderLabel.textColor = .systemOrange
    dietaryHeaderLabel.font = UIFont.boldSystemFont(ofSize: 16)
  }
  
  func setupDietFilterCollectionView() {
    dietFilterCollectionView = getDefaultCollectionView()
  }
  
  func setupHealthRestrictionLabel() {
    healthRestrictionLabel = UILabel()
    healthRestrictionLabel.text = "Health Restictions"
    healthRestrictionLabel.textAlignment = .center
    healthRestrictionLabel.textColor = .systemOrange
    healthRestrictionLabel.font = UIFont.boldSystemFont(ofSize: 16)
  }
  
  func setupHealthFilterCollectionView() {
    healthFilterCollectionView = getDefaultCollectionView()
    healthFilterCollectionView.allowsMultipleSelection = true
  }
  
  func setupSearchRecipesButton() {
    searchRecipesButton = UIButton()
    searchRecipesButton.setTitle("Search recipes", for: .normal)
    searchRecipesButton.layer.cornerRadius = 18
    searchRecipesButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    searchRecipesButton.backgroundColor = .systemGreen
  }
  
  func getDefaultCollectionView() -> UICollectionView {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.isScrollEnabled = false
    collectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.identifier)
    collectionView.backgroundColor = .systemYellow
    return collectionView
  }
  
  @objc func buttonPressed() {
    // when pressed display the list
  }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension FilterRecipeView: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 175, height: 55)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 25, left: 5, bottom: 25, right: 5)
  }
}


// MARK: - UICollectionViewDataSource
extension FilterRecipeView: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if collectionView == dietFilterCollectionView {
      return dietaryFilters.count
    }
    return healthFilters.count
  }
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    if collectionView == dietFilterCollectionView {
      //swiftlint:disable force_cast
      let cellA = dietFilterCollectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.identifier, for: indexPath) as! FilterCollectionViewCell
      
      let dietRestr = dietaryFilters[indexPath.row]
      cellA.bindCell(with: dietRestr)
      return cellA
    } else {
      //swiftlint:disable force_cast
      let cellB = healthFilterCollectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.identifier, for: indexPath) as! FilterCollectionViewCell
      
      let healthRestr = healthFilters[indexPath.row]
      cellB.bindCell(with: healthRestr)
      return cellB
    }
  }
}


// MARK: - UIcollectionViewDelegate
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
      
      dietaryHeaderLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: VT.topContraint),
      dietaryHeaderLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      dietaryHeaderLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      dietFilterCollectionView.topAnchor.constraint(equalTo: dietaryHeaderLabel.bottomAnchor),
      dietFilterCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      dietFilterCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      dietFilterCollectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: VT.dietCollMult),
      
      healthRestrictionLabel.topAnchor.constraint(equalTo: dietFilterCollectionView.bottomAnchor, constant: VT.topContraint),
      healthRestrictionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      healthRestrictionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      healthFilterCollectionView.topAnchor.constraint(equalTo: healthRestrictionLabel.bottomAnchor),
      healthFilterCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      healthFilterCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      searchRecipesButton.topAnchor.constraint(equalTo: healthFilterCollectionView.bottomAnchor),
      searchRecipesButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: VT.searchButtonLead),
      searchRecipesButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -VT.searchButtonLead),
      searchRecipesButton.heightAnchor.constraint(equalToConstant: VT.searchButtonHeight),
      searchRecipesButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -VT.searchButtonHeight)
    ])
  }
}
