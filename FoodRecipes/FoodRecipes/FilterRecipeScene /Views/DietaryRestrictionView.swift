//
//  DietaryRestrictionView.swift
//  FoodRecipes
//
//  Created by Ana on 28/04/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

protocol DietaryRestrictionViewDelegate: FilterRecipeView {
  func didSelectDietRestrict()
}

final class DietaryRestrictionView: UIView {
  
  private weak var delegate: DietaryRestrictionViewDelegate?
  private var dietaryLabel: UILabel!
  private var dietFilterCollectionView: UICollectionView!
  
  private let dietaryFilters = ["balanced", "high-protein", "low-fat", "low-carb"]
  private(set) var selectedDietParameter = String()
  
  private enum VT {
    static let topConstraint: CGFloat = 15
  }
  
  required init(delegate: DietaryRestrictionViewDelegate?) {
    super.init(frame: .zero)
    self.delegate = delegate
    
    setupUI()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


// MARK: - UICollectionViewDataSource
extension DietaryRestrictionView: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    dietaryFilters.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    //swiftlint:disable:next force_cast
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
    cell?.backgroundColor = ColorHelper.customRed
    
    selectedDietParameter = dietaryFilters[indexPath.row]
    delegate?.didSelectDietRestrict()
  }
  
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath)
    cell?.backgroundColor = ColorHelper.customYellow
  }
}


// MARK: - Private Zone
private extension DietaryRestrictionView {
  
  func setupDietaryLabel() {
    let font = UIFont.systemFont(ofSize: 16)
    dietaryLabel = UILabel(text: "Dietary Restrictions", font: font, textAlignment: .center, textColor: .black)
  }
  
  func setupDietFilterCollectionView() {
    let layout = CollectionViewLayout()
    dietFilterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    dietFilterCollectionView.dataSource = self
    dietFilterCollectionView.delegate = self
    dietFilterCollectionView.isScrollEnabled = false
    dietFilterCollectionView.backgroundColor = ColorHelper.customWhite
    dietFilterCollectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.identifier)
  }
  
  func setupUI() {
    setupDietaryLabel()
    setupDietFilterCollectionView()
    
    addSubViews()
    setupConstraints()
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
      dietaryLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: VT.topConstraint),
      dietaryLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      dietaryLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      
      dietFilterCollectionView.topAnchor.constraint(equalTo: dietaryLabel.bottomAnchor, constant: VT.topConstraint),
      dietFilterCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      dietFilterCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      dietFilterCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}
