//
//  FilterCollectionViewCell.swift
//  FoodRecipes
//
//  Created by Ana on 19/03/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

final class FilterCollectionViewCell: UICollectionViewCell, Identifiable {
  
  private var filterNameLabel: UILabel!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .systemRed
    layer.cornerRadius = 40
    
    setupFilterNamaLabel()
    
    addSubViews()
    setupConstraints()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func bindCell(with healthRestr: String) {
    filterNameLabel.text = healthRestr
  }
}


// MARK: - Private Zone
private extension FilterCollectionViewCell {
  
  func setupFilterNamaLabel() {
    filterNameLabel = UILabel()
    filterNameLabel.textAlignment = .center
    filterNameLabel.textColor = .white
    filterNameLabel.font = UIFont.systemFont(ofSize: 14)
  }
}


// MARK: - Constraints Zone
private extension FilterCollectionViewCell {
  
  func addSubViews() {

    addSubviewWithoutConstr(filterNameLabel)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      
      filterNameLabel.topAnchor.constraint(equalTo: topAnchor),
      filterNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      filterNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      filterNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}
