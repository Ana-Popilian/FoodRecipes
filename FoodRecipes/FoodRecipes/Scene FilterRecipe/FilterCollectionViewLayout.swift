//
//  FilterCollectionViewLayout.swift
//  FoodRecipes
//
//  Created by Ana on 19/03/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

final class FilterCollectionViewLayout: UICollectionViewFlowLayout {
  
    private enum ViewTrait {
      static let minColumnWidth: CGFloat = 40
      static let cellHeight: CGFloat = 50
    }
    
    override func prepare() {
      super.prepare()
      
      guard let collectionView = collectionView else { return }
      
      let availableWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width
      let maxNumColumns = availableWidth / ViewTrait.minColumnWidth
      let cellWidth = (availableWidth / maxNumColumns).rounded(.down)
      
      self.itemSize = CGSize(width: cellWidth, height: ViewTrait.cellHeight)
      self.sectionInsetReference = .fromSafeArea
    }
  }
