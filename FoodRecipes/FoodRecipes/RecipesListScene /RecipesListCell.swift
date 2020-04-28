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
  private var labelsContainerView: UIView!
  private var recipeImageView: UIImageView!
  private var recipeNameLabel: UILabel!
  private var caloriesValueLabel: UILabel!
  
  private enum VT {
    static let containerMult: CGFloat = 0.8
    static let imageMult: CGFloat = 0.7
    static let defaultHorizontalSpacing: CGFloat = 15
    static let calorieHPadding: CGFloat = 5
    static let imageViewHorizontalSpacing: CGFloat = 20
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupRecipeContainerView()
    setupLabelsContainerView()
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
    recipeContainerView.backgroundColor = ColorHelper.customBlue
  }
  
  func setupRecipeImageView() {
    recipeImageView = UIImageView()
    recipeImageView.clipsToBounds = true
    recipeImageView.layer.cornerRadius = 24
    recipeImageView.contentMode = .scaleAspectFit
  }
  
  func setupLabelsContainerView() {
    labelsContainerView = UIView()
  }
  
  func setupRecipeNameLabel() {
    recipeNameLabel = getDefaultLabel()
    recipeNameLabel.numberOfLines = 3
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
    addSubviewWC(recipeContainerView)
    recipeContainerView.addSubviewWC(recipeImageView)
    recipeContainerView.addSubviewWC(labelsContainerView)
    labelsContainerView.addSubviewWC(recipeNameLabel)
    labelsContainerView.addSubviewWC(caloriesValueLabel)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      recipeContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: VT.defaultHorizontalSpacing),
      recipeContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -VT.defaultHorizontalSpacing),
      recipeContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: VT.containerMult),
      recipeContainerView.centerYAnchor.constraint(equalTo: centerYAnchor),
      
      recipeImageView.leadingAnchor.constraint(equalTo: recipeContainerView.leadingAnchor, constant: VT.imageViewHorizontalSpacing),
      recipeImageView.centerYAnchor.constraint(equalTo: recipeContainerView.centerYAnchor),
      recipeImageView.heightAnchor.constraint(equalTo: recipeContainerView.heightAnchor, multiplier: VT.imageMult),
      recipeImageView.widthAnchor.constraint(equalTo: recipeContainerView.heightAnchor, multiplier: VT.imageMult),
      
      labelsContainerView.centerYAnchor.constraint(equalTo: recipeContainerView.centerYAnchor),
      labelsContainerView.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: VT.defaultHorizontalSpacing),
      labelsContainerView.trailingAnchor.constraint(equalTo: recipeContainerView.trailingAnchor, constant: -VT.defaultHorizontalSpacing),
      
      recipeNameLabel.topAnchor.constraint(equalTo: labelsContainerView.topAnchor),
      recipeNameLabel.leadingAnchor.constraint(equalTo: labelsContainerView.leadingAnchor),
      recipeNameLabel.trailingAnchor.constraint(equalTo: labelsContainerView.trailingAnchor),
      
      caloriesValueLabel.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor, constant: VT.calorieHPadding),
      caloriesValueLabel.leadingAnchor.constraint(equalTo: labelsContainerView.leadingAnchor),
      caloriesValueLabel.trailingAnchor.constraint(equalTo: labelsContainerView.trailingAnchor),
      caloriesValueLabel.bottomAnchor.constraint(equalTo: labelsContainerView.bottomAnchor)
    ])
  }
}
