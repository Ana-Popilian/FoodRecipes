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
  private var scrollView: UIScrollView!
  private var containerView: UIView!
  private var containerImageView: UIView!
  private var recipeImageView: UIImageView!
  private var tableViewHeaderView: UIView!
  private var recipeTitleLabel: UILabel!
  private var ingredientsTitleLabel: UILabel!
  private var ingredientsTableView: UITableView!
  private var seeDirectionsButton: UIButton!
  
  private enum VT {
    static let imgViewHeightConstant: CGFloat = 120
    static let tableViewHeightConstant: CGFloat = 500
    static let searchButtonHeight: CGFloat = 45
  }
  
  required init(delegate: IngredientsListDelegate?) {
    super.init(frame: .zero)
    self.delegate = delegate
    backgroundColor = .systemYellow
    
    setupScrollView()
    setupContainerView()
    setupContainerImageView()
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
  
  func setupContainerImageView() {
    containerImageView = UIView()
    containerImageView.backgroundColor = .systemGray4
    containerImageView.clipsToBounds = true
    containerImageView.layer.cornerRadius = VT.imgViewHeightConstant / 2
  }
  
  func setupRecipeImageView() {
    recipeImageView = UIImageView()
    recipeImageView.image = ImageHelper.defaultPlaceholder
    recipeImageView.contentMode = .scaleAspectFit
  }
  
  func setuptableViewHeaderView() {
    tableViewHeaderView = UIView()
    tableViewHeaderView.backgroundColor = .systemGreen
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
    return 20
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //swiftlint:disable force_cast
    let cell = tableView.dequeueReusableCell(withIdentifier: IngredientsTableViewCell.identifier, for: indexPath) as! IngredientsTableViewCell
    //    let data = recipeData?.hits[indexPath.row]
    //    cell.bindCell(data!)
    
    return cell
  }
}


//extension IngredientsListView: UITableViewDelegate {
//
//  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//
//  }
//}


// MARK: - Constraints Zone
private extension IngredientsListView {
  
  func addSubViews() {
    addSubviewWithoutConstr(scrollView)
    scrollView.addSubviewWithoutConstr(containerView)
    containerView.addSubviewWithoutConstr(containerImageView)
    
    containerView.addSubviewWithoutConstr(ingredientsTableView)
    containerView.addSubviewWithoutConstr(seeDirectionsButton)
    
    containerImageView.addSubviewWithoutConstr(recipeImageView)
    
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
      
      containerImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      containerImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
      containerImageView.heightAnchor.constraint(equalToConstant: VT.imgViewHeightConstant),
      containerImageView.widthAnchor.constraint(equalToConstant: VT.imgViewHeightConstant),
      
      recipeImageView.centerXAnchor.constraint(equalTo: containerImageView.centerXAnchor),
      recipeImageView.centerYAnchor.constraint(equalTo: containerImageView.centerYAnchor),
      recipeImageView.heightAnchor.constraint(equalTo: containerImageView.heightAnchor, multiplier: 0.8),
      recipeImageView.widthAnchor.constraint(equalTo: containerImageView.heightAnchor, multiplier: 0.8),
      
      ingredientsTableView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: VT.imgViewHeightConstant),
      ingredientsTableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      ingredientsTableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      ingredientsTableView.heightAnchor.constraint(equalToConstant: VT.tableViewHeightConstant),
      
      //      tableViewHeaderView.topAnchor.constraint(equalTo: ingredientsTableView.topAnchor),
      tableViewHeaderView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      tableViewHeaderView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      tableViewHeaderView.heightAnchor.constraint(equalToConstant: 80),
      
      recipeTitleLabel.topAnchor.constraint(equalTo: tableViewHeaderView.topAnchor, constant: 10),
      recipeTitleLabel.leadingAnchor.constraint(equalTo: tableViewHeaderView.leadingAnchor),
      recipeTitleLabel.trailingAnchor.constraint(equalTo: tableViewHeaderView.trailingAnchor),
      
      ingredientsTitleLabel.topAnchor.constraint(equalTo: recipeTitleLabel.bottomAnchor, constant: 10),
      ingredientsTitleLabel.leadingAnchor.constraint(equalTo: tableViewHeaderView.leadingAnchor, constant: 10),
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
