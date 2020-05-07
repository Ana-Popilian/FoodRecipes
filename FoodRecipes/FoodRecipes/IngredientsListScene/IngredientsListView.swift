//
//  IngredientsListView.swift
//  FoodRecipes
//
//  Created by Ana on 31/03/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

protocol IngredientsListDelegate where Self: UIViewController {
  func didPressDirectionsButton()
}

final class IngredientsListView: UIView, UIScrollViewDelegate {
  
  private weak var delegate: IngredientsListDelegate?
  private var ingredientsData = [String]()
  private var recipeTitle = String()
  private var imageData: URL!
  private var containerView: UIView!
  private var recipeImageView: UIImageView!
  private var recipeTitleLabel: UILabel!
  private var ingredientsTitleLabel: UILabel!
  private var ingredientsTableView: UITableView!
  private var buttonContainerView: UIView!
  private var seeDirectionsButton: UIButton!
  
  private enum VT {
    static let imgViewHeightConstant: CGFloat = 120
    static let imageMultiplier: CGFloat = 0.8
    static let defaulHeightConst: CGFloat = 10
    static let ingrHPadding: CGFloat = 20
    static let tableViewBottomPadding: CGFloat = -65
    static let searchButtonHeight: CGFloat = 45
    static let buttonHPadding: CGFloat = 35
  }
  
  required init(delegate: IngredientsListDelegate?) {
    super.init(frame: .zero)
    self.delegate = delegate
    backgroundColor = ColorHelper.customYellow
    
    setupUI()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func updateIngredientsData(_ ingredients: [String]) {
    ingredientsData = ingredients
    ingredientsTableView.reloadData()
  }
  
  func updateImageView(_ image: URL) {
    imageData = image
    let imageUrl = image
    recipeImageView.downloadImage(from: imageUrl)
  }
  
  func updateTitleLabel(_ title: String) {
    recipeTitle = title
    recipeTitleLabel.text = recipeTitle
  }
}


// MARK: - Private Zone
private extension IngredientsListView {
  
  func setupRecipeImageView() {
    recipeImageView = UIImageView()
    recipeImageView.contentMode = .scaleAspectFit
    recipeImageView.clipsToBounds = true
    recipeImageView.layer.cornerRadius = VT.imgViewHeightConstant / 4
  }
  
  func setupRecipeTitleLabel() {
    let font = UIFont.boldSystemFont(ofSize: 18)
    recipeTitleLabel = UILabel(font: font, textAlignment: .center, textColor: .white)
    recipeTitleLabel.numberOfLines = 3
  }
  
  func setupIngredinetsListLabel() {
    let font = UIFont.boldSystemFont(ofSize: 17)
    ingredientsTitleLabel = UILabel(text: "Ingredients:", font: font, textAlignment: .natural, textColor: .white)
    ingredientsTitleLabel.numberOfLines = 2
  }
  
  func setupIngredientsTableView() {
    ingredientsTableView = UITableView()
    ingredientsTableView.dataSource = self
    ingredientsTableView.backgroundColor = ColorHelper.customWhite
    ingredientsTableView.separatorStyle = .none
    ingredientsTableView.register(IngredientsTableViewCell.self, forCellReuseIdentifier: IngredientsTableViewCell.identifier)
  }
  
  func setupButtonContainerView() {
    buttonContainerView = UIView()
    buttonContainerView.backgroundColor = ColorHelper.customWhite
  }
  
  func setupSeeDirectionsButton() {
    seeDirectionsButton = CustomButton()
    seeDirectionsButton.setTitle("See Directions", for: .normal)
    seeDirectionsButton.layer.cornerRadius = 15
    seeDirectionsButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    seeDirectionsButton.isEnabled = true
  }
  
  func setupUI() {
    setupRecipeImageView()
    setupRecipeTitleLabel()
    setupIngredinetsListLabel()
    setupIngredientsTableView()
    setupButtonContainerView()
    setupSeeDirectionsButton()
    
    addSubViews()
    setupConstraints()
  }
  
  @objc func buttonPressed() {
    delegate?.didPressDirectionsButton()
  }
}


// MARK: - UITableViewDataSource
extension IngredientsListView: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return ingredientsData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //swiftlint:disable force_cast
    let cell = tableView.dequeueReusableCell(withIdentifier: IngredientsTableViewCell.identifier, for: indexPath) as! IngredientsTableViewCell
    let ingredient = ingredientsData[indexPath.row]
    cell.bindCell(ingredient)
    return cell
  }
}


// MARK: - Constraints Zone
private extension IngredientsListView {
  
  func addSubViews() {
    
    addSubviewWC(recipeImageView)
    addSubviewWC(recipeTitleLabel)
    addSubviewWC(ingredientsTitleLabel)
    addSubviewWC(ingredientsTableView)
    addSubviewWC(buttonContainerView)
    buttonContainerView.addSubviewWC(seeDirectionsButton)
  }
  
  func setupConstraints() {
    
    NSLayoutConstraint.activate([
      
      recipeImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: VT.defaulHeightConst),
      recipeImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      recipeImageView.heightAnchor.constraint(equalToConstant: VT.imgViewHeightConstant),
      recipeImageView.widthAnchor.constraint(equalToConstant: VT.imgViewHeightConstant),
      
      recipeTitleLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: VT.defaulHeightConst),
      recipeTitleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      recipeTitleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      
      ingredientsTitleLabel.topAnchor.constraint(equalTo: recipeTitleLabel.bottomAnchor, constant: VT.defaulHeightConst),
      ingredientsTitleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: VT.ingrHPadding),
      ingredientsTitleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      
      ingredientsTableView.topAnchor.constraint(equalTo: ingredientsTitleLabel.bottomAnchor, constant: VT.defaulHeightConst),
      ingredientsTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      ingredientsTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      ingredientsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: VT.tableViewBottomPadding),
      
      buttonContainerView.topAnchor.constraint(equalTo: ingredientsTableView.bottomAnchor),
      buttonContainerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      buttonContainerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      buttonContainerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
      
      seeDirectionsButton.leadingAnchor.constraint(equalTo: buttonContainerView.leadingAnchor, constant: VT.buttonHPadding),
      seeDirectionsButton.trailingAnchor.constraint(equalTo: buttonContainerView.trailingAnchor, constant: -VT.buttonHPadding),
      seeDirectionsButton.heightAnchor.constraint(equalToConstant: VT.searchButtonHeight),
      seeDirectionsButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -VT.defaulHeightConst)
    ])
  }
}
