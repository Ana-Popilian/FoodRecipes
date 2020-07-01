//
//  IngredientsListViewController.swift
//  FoodRecipes
//
//  Created by Ana on 31/03/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

final class IngredientsListViewController: UIViewController {
  
  private var mainView: IngredientsListView!
  private var modelData: Recipe!
  
  required init(withModel model: Recipe) {
    super.init(nibName: nil, bundle: nil)
    modelData = model
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    navigationItem.title = "List of ingredients"
    
    mainView = IngredientsListView(delegate: self)
    view = mainView
    
    navigationController?.navigationBar.barTintColor = ColorHelper.customWhite
    navigationController?.navigationBar.tintColor = UIColor.black
    setTitle()
  }
  
  override func viewDidLoad() {
    
    mainView.updateIngredientsData(modelData.ingredientLines)
    mainView.updateImageView(modelData.image)
    mainView.updateTitleLabel(modelData.label)
  }
  
  func setTitle() {
    let font =  UIFont.systemFont(ofSize: 17)
    let label = UILabel(text: "List of ingredients", font: font, textAlignment: .center, textColor: .black)
    self.navigationItem.titleView = label
  }
}


// MARK: - IngredientsListDelegate
extension IngredientsListViewController: IngredientsListDelegate {
  
  func didPressDirectionsButton() {
    let url = modelData.url
    let nextViewController = RecipeDirectionsViewController(withUrl: url)
    navigationController?.pushViewController(nextViewController, animated: true)
  }
}
