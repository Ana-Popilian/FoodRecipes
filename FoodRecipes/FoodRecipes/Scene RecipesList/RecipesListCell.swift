//
//  RecipesListCell.swift
//  FoodRecipes
//
//  Created by Ana on 18/03/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

final class RecipesListCell: UITableViewCell, Identifiable {
  
  private var recipeContainerView: UIView!
  private var recipeImageView: UIImageView!
  private var recipeNameLabel: UILabel!
  private var caloriesValueLabel: UILabel!
  
  private enum ViewTrait {
    static let defaultHorizontalSpacing: CGFloat = 15
    static let titleTopPaddind: CGFloat = 35
    static let imageViewHorizontalSpacing: CGFloat = 20
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupRecipeContainerView()
    setupRecipeImageView()
    setupRecipeNameLabel()
    setupCaloriesValueLabel()
    
    addSubViews()
    setupConstraints()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func bindCell(_ model: Hit) {
    recipeNameLabel.text = model.recipe.label
    let calories = Int(model.recipe.calories)
    caloriesValueLabel.text = "Calories: \(calories)"
    
    let imageUrl = model.recipe.image
    recipeImageView.downloadImage(from: imageUrl, downloadFinishedHandler: {
    })
  }
}


// MARK: - Private Zone
private extension RecipesListCell {
  
  func setupRecipeContainerView() {
    recipeContainerView = UIView()
    recipeContainerView.layer.cornerRadius = 30
    recipeContainerView.backgroundColor = .systemYellow
  }
  
  func setupRecipeImageView() {
    recipeImageView = UIImageView()
    recipeImageView.image = UIImage(named: "pasta")
    recipeImageView.clipsToBounds = true
    recipeImageView.layer.cornerRadius = 24
    recipeImageView.contentMode = .scaleAspectFit
  }
  
  func setupRecipeNameLabel() {
    recipeNameLabel = getDefaultLabel()
    recipeNameLabel.font = UIFont.boldSystemFont(ofSize: 14)
  }
  
  func setupCaloriesValueLabel() {
    caloriesValueLabel = getDefaultLabel()
    caloriesValueLabel.font = UIFont.systemFont(ofSize: 14)
  }
  
  func getDefaultLabel() -> UILabel {
    let label = UILabel()
    label.textColor = .black
    return label
  }
}


// MARK: - Constraints Zone
private extension RecipesListCell {
  
  func addSubViews() {
    addSubviewWithoutConstr(recipeContainerView)
    recipeContainerView.addSubviewWithoutConstr(recipeImageView)
    recipeContainerView.addSubviewWithoutConstr(recipeNameLabel)
    recipeContainerView.addSubviewWithoutConstr(caloriesValueLabel)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      recipeContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ViewTrait.defaultHorizontalSpacing),
      recipeContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ViewTrait.defaultHorizontalSpacing),
      recipeContainerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
      recipeContainerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      
      recipeImageView.leadingAnchor.constraint(equalTo: recipeContainerView.leadingAnchor, constant: ViewTrait.imageViewHorizontalSpacing),
      recipeImageView.centerYAnchor.constraint(equalTo: recipeContainerView.centerYAnchor),
      recipeImageView.heightAnchor.constraint(equalTo: recipeContainerView.heightAnchor, multiplier: 0.7),
      recipeImageView.widthAnchor.constraint(equalTo: recipeContainerView.heightAnchor, multiplier: 0.7),
      
      recipeNameLabel.topAnchor.constraint(equalTo: recipeContainerView.topAnchor, constant: ViewTrait.titleTopPaddind),
      recipeNameLabel.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: ViewTrait.defaultHorizontalSpacing),
      recipeNameLabel.trailingAnchor.constraint(equalTo: recipeContainerView.trailingAnchor, constant: -ViewTrait.defaultHorizontalSpacing),
      
      caloriesValueLabel.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor, constant: 5),
      caloriesValueLabel.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: ViewTrait.defaultHorizontalSpacing),
      caloriesValueLabel.trailingAnchor.constraint(equalTo: recipeContainerView.trailingAnchor, constant: -ViewTrait.defaultHorizontalSpacing)
    ])
  }
}
