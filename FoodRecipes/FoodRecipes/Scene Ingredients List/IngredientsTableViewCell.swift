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
//    "+ \(String(describing: ingredient))"
  }
}


// MARK: - Private Zone
private extension IngredientsTableViewCell {
  func setupIngredintLabel() {
    ingredientLabel = UILabel()
    ingredientLabel.font = UIFont.systemFont(ofSize: 15)
    ingredientLabel.textAlignment = .natural
    ingredientLabel.text = "+  1/4 cup of water"
  }
}


// MARK: - Constraints Zone
private extension IngredientsTableViewCell {
  
  func addSubViews() {
    addSubviewWithoutConstr(ingredientLabel)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      ingredientLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
      ingredientLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
      ingredientLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      ingredientLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
    ])
  }
}
