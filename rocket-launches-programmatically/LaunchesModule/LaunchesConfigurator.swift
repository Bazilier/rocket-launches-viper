//
//  LaunchesConfigurator.swift
//  rocket-launches-programmatically
//
//  Created by Кирилл Васильев on 12.08.2023.
//

import Foundation
import UIKit

class LaunchesConfigurator {
    static func configure(with rocket: RocketEntity) -> LaunchesViewController {
        let viewController = LaunchesViewController()
        print("Configurator: Presenter should be set up here: \(String(describing: viewController.presenter))")
        let interactor = LaunchesInteractor(rocket: rocket)
        print("Interactor initialized")
        let presenter = LaunchesPresenter()
        print("Presenter initialized")
        let router = LaunchesRouter()
        print("Router initialized")


        viewController.presenter = presenter
        print("Configurator: Presenter should be set up now: \(String(describing: viewController.presenter))")

        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter
        router.viewController = viewController

        return viewController
    }
}

