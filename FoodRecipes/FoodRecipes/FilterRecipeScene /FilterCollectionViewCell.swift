//
//  FilterCollectionViewCell.swift
//  FoodRecipes
//
//  Created by Ana on 19/03/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

final class FilterCollectionViewCell: UICollectionViewCell {
  
  private var filterNameLabel: UILabel!
  
  private enum VT {
    static let cornerRadius: CGFloat = 30
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = ColorHelper.customYellow
    layer.cornerRadius = VT.cornerRadius
    
    setupUI()
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
    let font = UIFont.systemFont(ofSize: 15)
    filterNameLabel = UILabel(font: font, textAlignment: .center, textColor: .white)
  }
  
  func setupUI() {
    setupFilterNamaLabel()
    addSubViews()
    setupConstraints()
  }
}


// MARK: - Constraints Zone
private extension FilterCollectionViewCell {
  
  func addSubViews() {
    addSubviewWC(filterNameLabel)
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
