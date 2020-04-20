//
//  FilterRecipeView.swift
//  FoodRecipes
//
//  Created by Ana on 18/03/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

protocol FilterRecipeDelegate: UIViewController {
  func didSelectedSearchRecipes(withDetails details: RecipeData)
}

final class FilterRecipeView: UIView {
  
  private weak var delegate: FilterRecipeDelegate?
  private var searchBar: UISearchBar!
  private var dietaryLabel: UILabel!
  private var dietFilterCollectionView: UICollectionView!
  private var healthRestrictionLabel: UILabel!
  private var healthFilterCollectionView: UICollectionView!
  private var searchRecipesButton: UIButton!
  
  private var typedIngredient: String!
  private var selectedDietParameter: String!
  private var selectedHealthParameters = [String]()
  
  let dietaryFilters = ["balanced", "high-protein", "low-fat", "low-carb"]
  let healthFilters = ["peanut-free", "tree-nut-free", "alcohol-free", "vegetarian", "vegan", "sugar-conscious"]
  
  private enum VT {
    static let topContraint: CGFloat = 15
    static let dietCollMult: CGFloat = 0.23
    static let searchButtonHeight: CGFloat = UIScreen.main.bounds.width * 0.13
    static let buttonBottomHeight: CGFloat = UIScreen.main.bounds.height / 40.5
    static let searchButtonLead: CGFloat = 35
  }
  
  required init(delegate: FilterRecipeDelegate?) {
    super.init(frame: .zero)
    self.delegate = delegate
    backgroundColor = ColorHelper.customBlue
    
    setupSearchBar()
    setupDietaryLabel()
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
  
  func prepareParametersForParser() -> RecipeData {
    return RecipeData(ingredient: typedIngredient, healthRestr: selectedHealthParameters, dietRestr: selectedDietParameter)
  }
}


// MARK: - Private Zone
private extension FilterRecipeView {
  
  func setupSearchBar() {
    searchBar = UISearchBar()
    searchBar.placeholder = "Search recipe by ingredient"
    searchBar.isTranslucent = false
    searchBar.delegate = self
  }
  
  func setupDietaryLabel() {
    dietaryLabel = getDefaultLabel()
    dietaryLabel.text = "Dietary Restrictions"
  }
  
  func setupDietFilterCollectionView() {
    dietFilterCollectionView = getDefaultCollectionView()
  }
  
  func setupHealthRestrictionLabel() {
    healthRestrictionLabel = getDefaultLabel()
    healthRestrictionLabel.text = "Health Restictions"
  }
  
  func setupHealthFilterCollectionView() {
    healthFilterCollectionView = getDefaultCollectionView()
    healthFilterCollectionView.allowsMultipleSelection = true
  }
  
  func setupSearchRecipesButton() {
    searchRecipesButton = CustomButton()
    searchRecipesButton.setTitle("Search recipes", for: .normal)
    searchRecipesButton.layer.cornerRadius = 15
    searchRecipesButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    searchRecipesButton.isEnabled = false
  }
  
  func getDefaultLabel() -> UILabel {
    let label = UILabel()
    label.textAlignment = .center
    label.textColor = ColorHelper.customPurple
    label.font = UIFont.systemFont(ofSize: 16)
    return label
  }
  
  func getDefaultCollectionView() -> UICollectionView {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.isScrollEnabled = false
    collectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.identifier)
    collectionView.backgroundColor = ColorHelper.customBlue
    return collectionView
  }
  
  @objc func buttonPressed() {
    let details = RecipeData(ingredient: typedIngredient, healthRestr: selectedHealthParameters, dietRestr: selectedDietParameter)
    delegate?.didSelectedSearchRecipes(withDetails: details)
  }
}


// MARK: - UISearchBarDelegate
extension FilterRecipeView: UISearchBarDelegate {
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    let word = searchText
    typedIngredient = word
    searchRecipesButton.isEnabled = !word.isBlank
    hideKeyboardWhenTappedAround()
  }
  
  func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    
    let regex = try! NSRegularExpression(pattern: "^[a-zA-Z]+$")
    return regex.matches(text)
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.endEditing(true)
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
    if collectionView == dietFilterCollectionView {
      let cell = collectionView.cellForItem(at: indexPath)
      cell?.backgroundColor = ColorHelper.customPurple
      
      let diet = dietaryFilters[indexPath.item]
      selectedDietParameter = diet
      
    } else {
      let cell = collectionView.cellForItem(at: indexPath)
      cell?.backgroundColor = ColorHelper.customPurple
      
      let health = healthFilters[indexPath.item]
      selectedHealthParameters.append(health)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    if collectionView == healthFilterCollectionView {
      let health = healthFilters[indexPath.item]
      let index = selectedHealthParameters.firstIndex(of: health)!
      selectedHealthParameters.remove(at: index)
    }
    let cell = collectionView.cellForItem(at: indexPath as IndexPath)
    cell?.backgroundColor = ColorHelper.customRed
  }
}


// MARK: - Constraints Zone
private extension FilterRecipeView {
  
  func addSubViews() {
    addSubviewWithoutConstr(searchBar)
    addSubviewWithoutConstr(dietaryLabel)
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
      
      dietaryLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: VT.topContraint),
      dietaryLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      dietaryLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      dietFilterCollectionView.topAnchor.constraint(equalTo: dietaryLabel.bottomAnchor),
      dietFilterCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      dietFilterCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      dietFilterCollectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: VT.dietCollMult),
      
      healthRestrictionLabel.topAnchor.constraint(equalTo: dietFilterCollectionView.bottomAnchor, constant: VT.topContraint),
      healthRestrictionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      healthRestrictionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      healthFilterCollectionView.topAnchor.constraint(equalTo: healthRestrictionLabel.bottomAnchor),
      healthFilterCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      healthFilterCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      searchRecipesButton.topAnchor.constraint(equalTo: healthFilterCollectionView.bottomAnchor, constant: VT.topContraint),
      searchRecipesButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: VT.searchButtonLead),
      searchRecipesButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -VT.searchButtonLead),
      searchRecipesButton.heightAnchor.constraint(equalToConstant: VT.searchButtonHeight),
      searchRecipesButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -VT.buttonBottomHeight)
    ])
  }
}
