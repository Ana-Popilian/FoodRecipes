//
//  CollectionViewLayout.swift
//  FoodRecipes
//
//  Created by Ana on 30/03/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

extension FilterRecipeView {
  
  func getDefaultLabel() -> UILabel {
    let label = UILabel()
    label.textAlignment = .center
    label.textColor = ColorHelper.customPurple
    label.font = UIFont.systemFont(ofSize: 16)
    return label
  }
  
  func hideKeyboardWhenTappedAround() {
    let tapGesture = UITapGestureRecognizer(target: self,
                                            action: #selector(hideKeyboard))
    tapGesture.cancelsTouchesInView = false
    addGestureRecognizer(tapGesture)
  }
  
  @objc func hideKeyboard() {
    endEditing(true)
  }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension FilterRecipeView: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = UIScreen.main.bounds.width * 0.45
    let height = UIScreen.main.bounds.width * 0.15
    return CGSize(width: width, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
  }
}
