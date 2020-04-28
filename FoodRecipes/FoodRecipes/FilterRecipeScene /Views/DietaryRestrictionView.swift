//
//  DietaryRestrictionView.swift
//  FoodRecipes
//
//  Created by Ana on 28/04/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

protocol DietaryRestrictionViewDelegate: FilterRecipeView {
  
}

final class DietaryRestrictionView: UIView {
  
  private var dietaryLabel: UILabel!
  private var dietFilterCollectionView: UICollectionView!
  private weak var delegate: DietaryRestrictionViewDelegate?
  
  let dietaryFilters = ["balanced", "high-protein", "low-fat", "low-carb"]
  private var selectedDietParameter: String!
  
  required init(delegate: DietaryRestrictionViewDelegate?) {
    super.init(frame: .zero)
    self.delegate = delegate
    
    setupDietaryLabel()
    setupDietFilterCollectionView()
    
    addSubViews()
    setupConstraints()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}


// MARK: - Private Zone
extension DietaryRestrictionView {
  
  func setupDietaryLabel() {
    let font = UIFont.systemFont(ofSize: 16)
    dietaryLabel = UILabel(text: "Dietary Restrictions", font: font, textAlignment: .center, textColor: ColorHelper.customPurple)
  }
  
  func setupDietFilterCollectionView() {
    dietFilterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    dietFilterCollectionView.dataSource = self
    dietFilterCollectionView.delegate = self
    dietFilterCollectionView.isScrollEnabled = false
    dietFilterCollectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.identifier)
    dietFilterCollectionView.backgroundColor = ColorHelper.customBlue
  }
}


// MARK: - UICollectionViewDataSource
extension DietaryRestrictionView: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    4
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    //swiftlint:disable force_cast
    let cell = dietFilterCollectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.identifier, for: indexPath) as! FilterCollectionViewCell
    
    let dietRestr = dietaryFilters[indexPath.row]
    cell.bindCell(with: dietRestr)
    return cell
  }
}


// MARK: - UIcollectionViewDelegate
extension DietaryRestrictionView: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    let cell = collectionView.cellForItem(at: indexPath)
    cell?.backgroundColor = ColorHelper.customPurple
    
    let diet = dietaryFilters[indexPath.item]
    selectedDietParameter = diet
  }
}


// MARK: - Constraints Zone
private extension DietaryRestrictionView {
  
  func addSubViews() {
    addSubviewWC(dietaryLabel)
    addSubviewWC(dietFilterCollectionView)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      dietaryLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      dietaryLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      dietaryLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      
      dietFilterCollectionView.topAnchor.constraint(equalTo: dietaryLabel.bottomAnchor, constant: 10),
      dietFilterCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      dietFilterCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      dietFilterCollectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.23)
    ])
  }
}
