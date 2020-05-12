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
    static let verticalPadding: CGFloat = 10
  }
  
  override func prepare() {
    super.prepare()
    
    self.itemSize = CGSize(width: VT.cellWidth, height: VT.cellHeight)
    self.sectionInset = UIEdgeInsets(top: 0, left: VT.verticalPadding, bottom: 0, right: VT.verticalPadding)
  }
}
