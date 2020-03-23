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
    
    backgroundColor = .systemBlue
    layer.cornerRadius = 35
    
    setupFilterNamaLabel()
    
    addSubViews()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
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
      
      filterNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
      filterNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
      filterNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 5),
      filterNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5)
    ])
  }
}