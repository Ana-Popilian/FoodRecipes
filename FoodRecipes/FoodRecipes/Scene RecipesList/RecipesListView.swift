//
//  RecipesListView.swift
//  FoodRecipes
//
//  Created by Ana on 17/03/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

protocol RecipesListDelegate: UIViewController {
}

final class RecipesListView: UIView {
  
  private var recipesListTableView: UITableView!
  private weak var delegate: RecipesListDelegate?
  
  required init(delegate: RecipesListDelegate?) {
    super.init(frame: .zero)
    self.delegate = delegate
    
    setupRecipesListTableView()
    
    addSubViews()
    setupConstraints()
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
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
  }
}


// MARK: - UITableViewDataSource
extension RecipesListView: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    20
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //swiftlint:disable force_cast
    let cell = tableView.dequeueReusableCell(withIdentifier: RecipesListCell.identifier, for: indexPath) as! RecipesListCell
    
    return cell
  }
}


// MARK: - UITableViewDelegate
extension RecipesListView: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //implement later
  }
}


// MARK: - Constraints Zone
private extension RecipesListView {
  
  func addSubViews() {
    addSubviewWithoutConstr(recipesListTableView)
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
