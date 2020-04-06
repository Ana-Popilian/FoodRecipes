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
  private var scrollView: UIScrollView!
  private var containerView: UIView!
  private var recipeImageView: UIImageView!
  private var tableViewHeaderView: UIView!
  private var recipeTitleLabel: UILabel!
  private var ingredientsTitleLabel: UILabel!
  private var ingredientsTableView: UITableView!
  private var seeDirectionsButton: UIButton!
  
  private enum VT {
    static let imgViewHeightConstant: CGFloat = 120
    static let imageMultiplier: CGFloat = 0.8
    static let tableViewHeightConstant: CGFloat = 500
    static let tableViewHeaderHeight: CGFloat = 90
    static let searchButtonHeight: CGFloat = 45
  }
  
  required init(delegate: IngredientsListDelegate?) {
    super.init(frame: .zero)
    self.delegate = delegate
    backgroundColor = .systemYellow
    
    setupScrollView()
    setupContainerView()
    setupRecipeImageView()
    setuptableViewHeaderView()
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
  
  func setupScrollView() {
    scrollView = UIScrollView()
    scrollView.delegate = self
    scrollView.alwaysBounceVertical = true
  }
  
  func setupContainerView() {
    containerView = UIView()
  }
  
  func setupRecipeImageView() {
    recipeImageView = UIImageView()
    recipeImageView.contentMode = .scaleAspectFit
    recipeImageView.clipsToBounds = true
    recipeImageView.layer.cornerRadius = VT.imgViewHeightConstant / 4
  }
  
  func setuptableViewHeaderView() {
    tableViewHeaderView = UIView()
    //    tableViewHeaderView.backgroundColor = .systemGreen
  }
  
  func setupRecipeTitleLabel() {
    recipeTitleLabel = UILabel()
    recipeTitleLabel.text = "Lasagna"
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
    ingredientsTableView.isScrollEnabled = false
    ingredientsTableView.tableHeaderView = tableViewHeaderView
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
    addSubviewWithoutConstr(scrollView)
    scrollView.addSubviewWithoutConstr(containerView)
    
    containerView.addSubviewWithoutConstr(ingredientsTableView)
    containerView.addSubviewWithoutConstr(seeDirectionsButton)
    
    containerView.addSubviewWithoutConstr(recipeImageView)
    
    ingredientsTableView.addSubviewWithoutConstr(tableViewHeaderView)
    tableViewHeaderView.addSubviewWithoutConstr(recipeTitleLabel)
    tableViewHeaderView.addSubviewWithoutConstr(ingredientsTitleLabel)
    
  }
  
  func setupConstraints() {
    #warning("delete after implementing data source ingredientsTableView.heightAnchor.constraint(equalToConstant: VT.tableViewHeightConstant)")
    NSLayoutConstraint.activate([
      
      scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
      
      containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      containerView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
      
      recipeImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      recipeImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
      recipeImageView.heightAnchor.constraint(equalToConstant: VT.imgViewHeightConstant),
      recipeImageView.widthAnchor.constraint(equalToConstant: VT.imgViewHeightConstant),
      
      ingredientsTableView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: VT.imgViewHeightConstant),
      ingredientsTableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      ingredientsTableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      ingredientsTableView.heightAnchor.constraint(equalToConstant: VT.tableViewHeightConstant),
      
      tableViewHeaderView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      tableViewHeaderView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      tableViewHeaderView.heightAnchor.constraint(equalToConstant: VT.tableViewHeaderHeight),
      
      recipeTitleLabel.topAnchor.constraint(equalTo: tableViewHeaderView.topAnchor, constant: 15),
      recipeTitleLabel.leadingAnchor.constraint(equalTo: tableViewHeaderView.leadingAnchor),
      recipeTitleLabel.trailingAnchor.constraint(equalTo: tableViewHeaderView.trailingAnchor),
      
      ingredientsTitleLabel.topAnchor.constraint(equalTo: recipeTitleLabel.bottomAnchor, constant: 10),
      ingredientsTitleLabel.leadingAnchor.constraint(equalTo: tableViewHeaderView.leadingAnchor, constant: 15),
      ingredientsTitleLabel.trailingAnchor.constraint(equalTo: tableViewHeaderView.trailingAnchor),
      ingredientsTitleLabel.bottomAnchor.constraint(equalTo: tableViewHeaderView.bottomAnchor, constant: -10),
      
      seeDirectionsButton.topAnchor.constraint(equalTo: ingredientsTableView.bottomAnchor, constant: 10),
      seeDirectionsButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 35),
      seeDirectionsButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -35),
      seeDirectionsButton.heightAnchor.constraint(equalToConstant: VT.searchButtonHeight),
      seeDirectionsButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
    ])
  }
}
