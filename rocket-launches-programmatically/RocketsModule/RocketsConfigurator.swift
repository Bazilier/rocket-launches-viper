//
//  RocketsConfigurator.swift
//  rocket-launches-programmatically
//
//  Created by Кирилл Васильев on 4.10.2023.
//

import Foundation

class RocketsConfigurator {
    static func configure() -> RocketsViewController {
        
        let viewController = RocketsViewController()
        let interactor = RocketsInteractor()
        let presenter = RocketsPresenter(view: viewController, interactor: interactor)
        let router = RocketsRouter()

        viewController.presenter = presenter

        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router

        interactor.output = presenter

        router.viewController = viewController

        return viewController
    }
}
