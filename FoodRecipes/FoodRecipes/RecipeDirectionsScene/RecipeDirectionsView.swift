//
//  RecipeDirectionsView.swift
//  FoodRecipes
//
//  Created by Ana on 15/04/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit
import WebKit

final class RecipeDirectionsView: UIView {
  
  private var recipeDirectionsWebView: WKWebView!
  
  required init(withUrl url: String) {
    super.init(frame: .zero)
    
    setupRecipeDirectionsWebView(withUrl: url)
    setupUI()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


// MARK: - Private Zone
private extension RecipeDirectionsView {
  
  func setupRecipeDirectionsWebView(withUrl urlString: String) {
    recipeDirectionsWebView = WKWebView()
    let url = URL(string: urlString)!
    let request = URLRequest(url: url)
    recipeDirectionsWebView.load(request)
    recipeDirectionsWebView.accessibilityIdentifier = "recipe-directions-web-view"
  }
  
  func setupUI() {
    addSubViews()
    setupConstraints()
  }
}


// MARK: - Constraints Zone
private extension RecipeDirectionsView {
  
  func addSubViews() {
    addSubviewWC(recipeDirectionsWebView)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      recipeDirectionsWebView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      recipeDirectionsWebView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      recipeDirectionsWebView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      recipeDirectionsWebView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}
