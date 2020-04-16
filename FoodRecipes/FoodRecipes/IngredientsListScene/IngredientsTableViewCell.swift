//
//  IngredientsTableViewCell.swift
//  FoodRecipes
//
//  Created by Ana on 31/03/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

final class IngredientsTableViewCell: UITableViewCell, Identifiable {
  
  
  private var ingredientLabel: UILabel!
  
  private enum VT {
    static let defaultPadding: CGFloat = 5
    static let horizontalPadding: CGFloat = 15
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupIngredintLabel()
    addSubViews()
    setupConstraints()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func bindCell(_ ingredient: String) {
    ingredientLabel.text  = "+ \(ingredient)"
  }
}


// MARK: - Private Zone
private extension IngredientsTableViewCell {
  func setupIngredintLabel() {
    ingredientLabel = UILabel()
    ingredientLabel.font = UIFont.systemFont(ofSize: 16)
    ingredientLabel.textColor = ColorHelper.customPurple
    ingredientLabel.textAlignment = .natural
    ingredientLabel.numberOfLines = 3
  }
}


// MARK: - Constraints Zone
private extension IngredientsTableViewCell {
  
  func addSubViews() {
    addSubviewWithoutConstr(ingredientLabel)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      ingredientLabel.topAnchor.constraint(equalTo: topAnchor, constant: VT.defaultPadding),
      ingredientLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: VT.horizontalPadding),
      ingredientLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -VT.defaultPadding),
      ingredientLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -VT.defaultPadding)
    ])
  }
}
