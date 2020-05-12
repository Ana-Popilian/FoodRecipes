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
  private var dietaryRestrictionView: DietaryRestrictionView!
  private var healthRestrictionView: HealthRestrictionView!
  private var searchRecipesButton: UIButton!
  
  private var typedIngredient: String!
  
  private enum VT {
    static let topContraint: CGFloat = 15
    static let dietaryRestrictionViewMult: CGFloat = 0.3
    static let searchButtonHeight: CGFloat = UIScreen.main.bounds.width * 0.13
    static let buttonBottomHeight: CGFloat = UIScreen.main.bounds.height / 40.5
    static let searchButtonPadding: CGFloat = 35
  }
  
  required init(delegate: FilterRecipeDelegate?) {
    super.init(frame: .zero)
    self.delegate = delegate
    backgroundColor = ColorHelper.customWhite
    
    setupUI()
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


// MARK: - UISearchBarDelegate
extension FilterRecipeView: UISearchBarDelegate {
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    let word = searchText
    typedIngredient = word
    checkSearchButtonState()
    setupHideKeyboard()
  }
  
  func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    if text == "\n" {
      return true
    }
    
    return setupRegex(with: text)
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
  }
}


// MARK: - DietaryRestrictionViewDelegate
extension FilterRecipeView: DietaryRestrictionViewDelegate {
  
  func didSelectDietRestrict() {
    checkSearchButtonState()
  }
}


// MARK: - Private Zone
private extension FilterRecipeView {
  
  func setupSearchBar() {
    searchBar = UISearchBar()
    searchBar.placeholder = "Search recipe by ingredient"
    searchBar.searchTextField.backgroundColor = ColorHelper.customWhite
    searchBar.delegate = self
  }
  
  func setupDietaryRestrictionView() {
    dietaryRestrictionView = DietaryRestrictionView(delegate: self)
  }
  
  func setupHealthRestrictionView() {
    healthRestrictionView = HealthRestrictionView()
  }
  
  func setupSearchRecipesButton() {
    searchRecipesButton = CustomButton()
    searchRecipesButton.setTitle("Search recipes", for: .normal)
    searchRecipesButton.layer.cornerRadius = 15
    searchRecipesButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    searchRecipesButton.isEnabled = false
  }
  
  func setupUI() {
    setupSearchBar()
    setupDietaryRestrictionView()
    setupHealthRestrictionView()
    setupSearchRecipesButton()
    
    addSubViews()
    setupConstraints()
  }
  
  @objc func buttonPressed() {
    let healthData = healthRestrictionView.selectedHealthParameters
    let dietData = dietaryRestrictionView.selectedDietParameter
    let details = RecipeData(ingredient: typedIngredient, healthRestr: healthData, dietRestr: dietData)
    
    delegate?.didSelectedSearchRecipes(withDetails: details)
  }
  
  func setupHideKeyboard() {
    let tapGesture = UITapGestureRecognizer(target: self,
                                            action: #selector(resignResponder))
    tapGesture.cancelsTouchesInView = false
    addGestureRecognizer(tapGesture)
  }
  
  @objc func resignResponder() {
    endEditing(true)
  }
  
  func setupRegex(with text: String) -> Bool {
    do {
      let regex = try NSRegularExpression(pattern: "^[a-zA-Z]+$")
      return regex.matches(text)
    } catch {
      return false
    }
  }
  
  func checkSearchButtonState() {
    searchRecipesButton.isEnabled = searchBar.text!.isEmpty == false && dietaryRestrictionView.selectedDietParameter.isEmpty == false
  }
}


// MARK: - Constraints Zone
private extension FilterRecipeView {
  
  func addSubViews() {
    addSubviewWC(searchBar)
    addSubviewWC(dietaryRestrictionView)
    addSubviewWC(healthRestrictionView)
    addSubviewWC(searchRecipesButton)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      
      dietaryRestrictionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: VT.topContraint),
      dietaryRestrictionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      dietaryRestrictionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      dietaryRestrictionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: VT.dietaryRestrictionViewMult),
      
      healthRestrictionView.topAnchor.constraint(equalTo: dietaryRestrictionView.bottomAnchor),
      healthRestrictionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      healthRestrictionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      searchRecipesButton.topAnchor.constraint(equalTo: healthRestrictionView.bottomAnchor, constant: VT.topContraint),
      searchRecipesButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: VT.searchButtonPadding),
      searchRecipesButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -VT.searchButtonPadding),
      searchRecipesButton.heightAnchor.constraint(equalToConstant: VT.searchButtonHeight),
      searchRecipesButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -VT.buttonBottomHeight)
    ])
  }
}
