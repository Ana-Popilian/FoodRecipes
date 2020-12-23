//
//  FilterRecipeViewController.swift
//  FoodRecipes
//
//  Created by Ana on 18/03/2020.
//  Copyright © 2020 Ana Popilian. All rights reserved.
//

import UIKit

class FilterRecipeViewController: UIViewController {
    
    private var mainView: FilterRecipeView!
    private let networkManager: NetworkManagerProtocol
    var error: Error?
    var recipeData: RecipeModel!
    var injector: InjectorProtocol
    
    init(injector: InjectorProtocol) {
        self.networkManager = injector.makeNetworkManager()
        self.injector = injector
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView = FilterRecipeView(delegate: self)
        view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}


// MARK: - FilterRecipeDelegate
extension FilterRecipeViewController: FilterRecipeDelegate {
    
    func didSelectedSearchRecipes(withDetails details: RecipeData) {
        
        networkManager.getRecipes(ingr: details.ingredient,
                                  diet: details.dietRestr,
                                  healths: details.healthRestr,
                                  completionHandler: { [weak self] (model) in
                                    
                                    switch model {
                                    case let .failure(error):
                                        self?.error = error
                                        
                                    case let .success(data):
                                        self?.recipeData = data
                                        
                                        DispatchQueue.main.async {
                                            let nextViewController = self?.injector.makeRecipeListViewController(withModel: data) //RecipesListViewController(withModel: (data))
                                            self?.navigationController?.pushViewController(nextViewController!, animated: true)
                                        }
                                    }
                                  })
    }
}
