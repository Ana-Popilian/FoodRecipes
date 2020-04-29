//
//  CollectionViewLayout.swift
//  FoodRecipes
//
//  Created by Ana on 29/04/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

final class CollectionViewLayout: UICollectionViewFlowLayout {
  
  private enum VT {
    static let cellWidth: CGFloat = UIScreen.main.bounds.width * 0.45
    static let cellHeight: CGFloat = UIScreen.main.bounds.width * 0.15
    
  }
  
  override func prepare() {
    super.prepare()
    
    guard let collectionView = collectionView else {
      return
    }
    
    let availableWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width
    let maxNumColumns = availableWidth / VT.cellWidth
    let cellWidth = (availableWidth / maxNumColumns).rounded(.down)
    
    self.itemSize = CGSize(width: cellWidth, height: VT.cellHeight)
    self.sectionInsetReference = .fromSafeArea
  }
}
