//
//  HealthRestrictionView.swift
//  FoodRecipes
//
//  Created by Ana on 29/04/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

final class HealthRestrictionView: UIView {
  
  private var healthRestrictionLabel: UILabel!
  private var healthFilterCollectionView: UICollectionView!
  
  private let healthFilters = ["peanut-free", "tree-nut-free", "alcohol-free", "vegetarian", "vegan", "sugar-conscious"]
  private(set) var selectedHealthParameters = [String]()
  
  private enum VT {
    static let topConstraint: CGFloat = 10
  }
  
  required init() {
    super.init(frame: .zero)
    
    setupUI()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


// MARK: - UICollectionViewDataSource
extension HealthRestrictionView: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    healthFilters.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    //swiftlint:disable:next force_cast
    let cell = healthFilterCollectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.identifier, for: indexPath) as! FilterCollectionViewCell
    
    let dietRestr = healthFilters[indexPath.row]
    cell.bindCell(with: dietRestr)
    return cell
  }
}


// MARK: - UIcollectionViewDelegate
extension HealthRestrictionView: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath)
    cell?.backgroundColor = ColorHelper.customRed
    
    let health = healthFilters[indexPath.item]
    selectedHealthParameters.append(health)
  }
  
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    let health = healthFilters[indexPath.item]
    let index =  selectedHealthParameters.firstIndex(of: health)!
    selectedHealthParameters.remove(at: index)
    let cell = collectionView.cellForItem(at: indexPath as IndexPath)
    cell?.backgroundColor = ColorHelper.customYellow
  }
}


// MARK: - Private Zone
private extension HealthRestrictionView {
  
  func setupHealthRestrLabel() {
    let font = UIFont.systemFont(ofSize: 16)
    healthRestrictionLabel = UILabel(text: "Health Restrictions", font: font, textAlignment: .center, textColor: .black)
  }
  
  func setupHealthFilterCollectionView() {
    let layout = CollectionViewLayout()
    healthFilterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    healthFilterCollectionView.dataSource = self
    healthFilterCollectionView.delegate = self
    healthFilterCollectionView.isScrollEnabled = false
    healthFilterCollectionView.allowsMultipleSelection = true
    healthFilterCollectionView.backgroundColor = ColorHelper.customWhite
    healthFilterCollectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.identifier)
  }
  
  func setupUI() {
    setupHealthRestrLabel()
    setupHealthFilterCollectionView()
    
    addSubViews()
    setupConstraints()
  }
}


// MARK: - Constraints Zone
private extension HealthRestrictionView {
  
  func addSubViews() {
    addSubviewWC(healthRestrictionLabel)
    addSubviewWC(healthFilterCollectionView)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      healthRestrictionLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: VT.topConstraint),
      healthRestrictionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      healthRestrictionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      
      healthFilterCollectionView.topAnchor.constraint(equalTo: healthRestrictionLabel.bottomAnchor, constant: VT.topConstraint),
      healthFilterCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      healthFilterCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      healthFilterCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}
