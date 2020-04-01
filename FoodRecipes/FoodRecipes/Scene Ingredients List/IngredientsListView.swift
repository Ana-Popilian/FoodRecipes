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
  private var ingredinetsListLabel: UILabel!
  private var ingredientsTableView: UITableView!
  
  private enum ViewTrait {
    static let imgViewHeightConstant: CGFloat = 120
    static let tableViewHeightConstant: CGFloat = 2_000
  }
  
  required init(delegate: IngredientsListDelegate?) {
    super.init(frame: .zero)
    self.delegate = delegate
    
    setupScrollView()
    setupContainerView()
    setupContainerImageView()
    setupRecipeImageView()
    setuptableViewHeaderView()
    setupRecipeTitleLabel()
    setupIngredinetsListLabel()
    setupIngredientsTableView()
    
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
    containerImageView.backgroundColor = .red
    containerImageView.layer.cornerRadius = 100
  }
  
  func setupRecipeImageView() {
    recipeImageView = UIImageView()
    recipeImageView.image = ImageHelper.defaultPlaceholder
    recipeImageView.clipsToBounds = true
    recipeImageView.contentMode = .scaleAspectFit
    recipeImageView.layer.cornerRadius = 100
  }
  
  func setuptableViewHeaderView() {
    tableViewHeaderView = UIView()
    tableViewHeaderView.backgroundColor = .systemBlue
  }
  
  func setupRecipeTitleLabel() {
    recipeTitleLabel = UILabel()
    recipeTitleLabel.text = "Lasagna"
    recipeTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
    recipeTitleLabel.textAlignment = .center
  }
  
  func setupIngredinetsListLabel() {
    ingredinetsListLabel = UILabel()
    ingredinetsListLabel.text = "Ingredients:"
    ingredinetsListLabel.font = UIFont.boldSystemFont(ofSize: 16)
    ingredinetsListLabel.textAlignment = .left
  }
  
  func setupIngredientsTableView() {
    ingredientsTableView = UITableView()
    ingredientsTableView.dataSource = self
    ingredientsTableView.register(IngredientsTableViewCell.self, forCellReuseIdentifier: IngredientsTableViewCell.identifier)
    ingredientsTableView.isScrollEnabled = false
    ingredientsTableView.tableHeaderView = tableViewHeaderView
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


// MARK: - Constraints Zone
private extension IngredientsListView {
  
  func addSubViews() {
    addSubviewWithoutConstr(scrollView)
    scrollView.addSubviewWithoutConstr(containerView)
    containerView.addSubviewWithoutConstr(containerImageView)
    containerImageView.addSubviewWithoutConstr(recipeImageView)
    containerView.addSubviewWithoutConstr(ingredientsTableView)
    ingredientsTableView.addSubviewWithoutConstr(tableViewHeaderView)
    tableViewHeaderView.addSubviewWithoutConstr(recipeTitleLabel)
    tableViewHeaderView.addSubviewWithoutConstr(ingredinetsListLabel)
  }
  
  func setupConstraints() {
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
      containerImageView.heightAnchor.constraint(equalToConstant: ViewTrait.imgViewHeightConstant),
      
      recipeImageView.topAnchor.constraint(equalTo: containerImageView.topAnchor),
      recipeImageView.centerXAnchor.constraint(equalTo: containerImageView.centerXAnchor),
      recipeImageView.heightAnchor.constraint(equalToConstant: ViewTrait.imgViewHeightConstant),
      
      tableViewHeaderView.topAnchor.constraint(equalTo: ingredientsTableView.topAnchor),
      tableViewHeaderView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      tableViewHeaderView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      tableViewHeaderView.heightAnchor.constraint(equalToConstant: 80),
      
      recipeTitleLabel.topAnchor.constraint(equalTo: tableViewHeaderView.topAnchor, constant: 10),
      recipeTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      recipeTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      
      ingredinetsListLabel.topAnchor.constraint(equalTo: recipeTitleLabel.bottomAnchor, constant: 10),
      ingredinetsListLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
      ingredinetsListLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      
      ingredientsTableView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: ViewTrait.imgViewHeightConstant),
      ingredientsTableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      ingredientsTableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      ingredientsTableView.heightAnchor.constraint(equalToConstant: ViewTrait.tableViewHeightConstant),
      ingredientsTableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
      
    ])
  }
}
