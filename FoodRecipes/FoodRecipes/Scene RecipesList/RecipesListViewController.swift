//
//  ViewController.swift
//  FoodRecipes
//
//  Created by Ana on 17/03/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

class RecipesListViewController: UIViewController {
  
  private var mainView: RecipesListView!
  private var network: NetworkManager!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    mainView = RecipesListView(delegate: self)
    view = mainView
    view.backgroundColor = .yellow
    
    network = NetworkManager()
    network.getRecipes(ingr: "flour", diet: "balanced", health: "peanut-free", completionHandler: { [weak self] (result) in
      DispatchQueue.main.async {
        //         self?.mainView.updateData(result) }
        print(result)
      }
      
    })
  }
}

  extension RecipesListViewController: RecipesListDelegate {
  
}
