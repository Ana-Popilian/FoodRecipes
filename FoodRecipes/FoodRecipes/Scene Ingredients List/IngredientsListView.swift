//
//  IngredientsListView.swift
//  FoodRecipes
//
//  Created by Ana on 31/03/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

protocol IngredientsListDelegate where Self: UIViewController {
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
    backgroundColor = .systemYellow
    
    setupContainerView()
    setupRecipeImageView()
    setupRecipeTitleLabel()
    setupIngredinetsListLabel()
    setupIngredientsTableView()
    setupSeeDirectionsButton()
    
    addSubViews()
    setupConstraints()
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
    recipeImageView.downloadImage(from: imageUrl, downloadFinishedHandler: {
    })
  }
  
  func updateTitleLabel(_ title: String) {
    recipeTitle = title
    recipeTitleLabel.text = recipeTitle
  }
}

// MARK: - Private Zone
private extension IngredientsListView {
  
  func setupContainerView() {
    containerView = UIView()
  }
  
  func setupRecipeImageView() {
    recipeImageView = UIImageView()
    recipeImageView.contentMode = .scaleAspectFit
    recipeImageView.clipsToBounds = true
    recipeImageView.layer.cornerRadius = VT.imgViewHeightConstant / 4
  }
  
  func setupRecipeTitleLabel() {
    recipeTitleLabel = UILabel()
    recipeTitleLabel.numberOfLines = 2
    recipeTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
    recipeTitleLabel.textAlignment = .center
  }
  
  func setupIngredinetsListLabel() {
    ingredientsTitleLabel = UILabel()
    ingredientsTitleLabel.text = "Ingredients:"
    ingredientsTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
    ingredientsTitleLabel.textAlignment = .left
  }
  
  func setupIngredientsTableView() {
    ingredientsTableView = UITableView()
    ingredientsTableView.dataSource = self
    ingredientsTableView.register(IngredientsTableViewCell.self, forCellReuseIdentifier: IngredientsTableViewCell.identifier)
  }
  
  func setupSeeDirectionsButton() {
    seeDirectionsButton = CustomButton()
    seeDirectionsButton.setTitle("See Directions", for: .normal)
    seeDirectionsButton.layer.cornerRadius = 18
    seeDirectionsButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    seeDirectionsButton.isEnabled = true
  }
  
  @objc func buttonPressed() {
    
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
    
   addSubviewWithoutConstr(containerView)
    
    containerView.addSubviewWithoutConstr(recipeImageView)
    containerView.addSubviewWithoutConstr(recipeTitleLabel)
    containerView.addSubviewWithoutConstr(ingredientsTitleLabel)
    containerView.addSubviewWithoutConstr(ingredientsTableView)
    containerView.addSubviewWithoutConstr(seeDirectionsButton)
  }
  
  func setupConstraints() {
   
    NSLayoutConstraint.activate([
      
      containerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      containerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      containerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
      containerView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
      
      recipeImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: VT.defaulHeightConst),
      recipeImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
      recipeImageView.heightAnchor.constraint(equalToConstant: VT.imgViewHeightConstant),
      recipeImageView.widthAnchor.constraint(equalToConstant: VT.imgViewHeightConstant),
      
      recipeTitleLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: VT.defaulHeightConst),
      recipeTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      recipeTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      
      ingredientsTitleLabel.topAnchor.constraint(equalTo: recipeTitleLabel.bottomAnchor, constant: VT.defaulHeightConst),
      ingredientsTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: VT.ingrHPadding),
      ingredientsTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),

      ingredientsTableView.topAnchor.constraint(equalTo: ingredientsTitleLabel.bottomAnchor, constant: VT.defaulHeightConst),
      ingredientsTableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      ingredientsTableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      ingredientsTableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: VT.tableViewBottomPadding),
   
      seeDirectionsButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: VT.buttonHPadding),
      seeDirectionsButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -VT.buttonHPadding),
      seeDirectionsButton.heightAnchor.constraint(equalToConstant: VT.searchButtonHeight),
      seeDirectionsButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -VT.defaulHeightConst)
    ])
  }
}
