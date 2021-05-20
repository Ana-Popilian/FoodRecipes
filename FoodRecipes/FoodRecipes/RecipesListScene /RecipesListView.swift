//
//  RecipesListView.swift
//  FoodRecipes
//
//  Created by Ana on 17/03/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

protocol RecipesListDelegate: UIViewController {
   func pushViewController(model: Recipe)
}

protocol RecipesListViewProtocol: UIView {
   var delegate: RecipesListDelegate? { get set }
   
   func updateRecipeData(_ data: RecipeModel)
}

final class RecipesListView: UIView {
   
   weak var delegate: RecipesListDelegate?
   private var recipesListTableView: UITableView!
   private var recipeData: RecipeModel!
   
   required init() {
      super.init(frame: .zero)
      backgroundColor = ColorHelper.customWhite
      setupUI()
   }
   
   @available(*, unavailable)
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}

extension RecipesListView: RecipesListViewProtocol {
   func updateRecipeData(_ data: RecipeModel) {
      recipeData = data
   }
}


// MARK: - Private Zone
private extension RecipesListView {
   
   func setupRecipesListTableView() {
      recipesListTableView = UITableView()
      recipesListTableView.delegate = self
      recipesListTableView.dataSource = self
      recipesListTableView.register(RecipesListCell.self, forCellReuseIdentifier: RecipesListCell.identifier)
      recipesListTableView.rowHeight = 140
      recipesListTableView.separatorStyle = .none
      recipesListTableView.backgroundColor = ColorHelper.customWhite
      recipesListTableView.accessibilityIdentifier = "recipe-list-table-view"
   }
   
   func setupUI() {
      setupRecipesListTableView()
      
      addSubViews()
      setupConstraints()
   }
}


// MARK: - UITableViewDataSource
extension RecipesListView: UITableViewDataSource {
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return recipeData!.recipe.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      //swiftlint:disable force_cast
      let cell = tableView.dequeueReusableCell(withIdentifier: RecipesListCell.identifier, for: indexPath) as! RecipesListCell
      let data = recipeData?.recipe[indexPath.row]
      cell.bindCell(data!)
      
      return cell
   }
}


// MARK: - UITableViewDelegate
extension RecipesListView: UITableViewDelegate {
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let data = recipeData.recipe[indexPath.row]
      
      delegate?.pushViewController(model: data)
   }
}


// MARK: - Constraints Zone
private extension RecipesListView {
   
   func addSubViews() {
      addSubviewWC(recipesListTableView)
   }
   
   func setupConstraints() {
      NSLayoutConstraint.activate([
         recipesListTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
         recipesListTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
         recipesListTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
         recipesListTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
      ])
   }
}
