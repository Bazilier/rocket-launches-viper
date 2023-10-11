//
//  RocketsRouter.swift
//  rocket-launches-programmatically
//
//  Created by Кирилл Васильев on 12.08.2023.
//

import UIKit

class RocketsRouter: RocketsRouterProtocol {
    weak var viewController: UIViewController?
        
    /// Navigates to the Launches view for a specific rocket.
    func navigateToLaunches(forRocket rocket: RocketEntity) {
        let vc = LaunchesConfigurator.configure(with: rocket)
        vc.rocket = rocket
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .pageSheet
        viewController?.present(navController, animated: true, completion: nil)
    }
}
