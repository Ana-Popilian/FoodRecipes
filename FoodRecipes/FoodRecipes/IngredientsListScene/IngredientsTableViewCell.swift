//
//  IngredientsTableViewCell.swift
//  FoodRecipes
//
//  Created by Ana on 31/03/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

final class IngredientsTableViewCell: UITableViewCell {
  
  private var ingredientLabel: UILabel!
  
  private enum VT {
    static let defaultPadding: CGFloat = 10
    static let horizontalPadding: CGFloat = 20
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    backgroundColor = ColorHelper.customWhite
    setupUI()
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
    let font = UIFont.systemFont(ofSize: 16)
    ingredientLabel = UILabel(font: font, textAlignment: .natural, textColor: .black)
    ingredientLabel.numberOfLines = 3
  }
  
  func setupUI() {
    setupIngredintLabel()
    addSubViews()
    setupConstraints()
  }
}


// MARK: - Constraints Zone
private extension IngredientsTableViewCell {
  
  func addSubViews() {
    addSubviewWC(ingredientLabel)
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
