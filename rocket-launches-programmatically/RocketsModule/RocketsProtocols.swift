//
//  RocketsProtocols.swift
//  rocket-launches-programmatically
//
//  Created by Кирилл Васильев on 4.10.2023.
//

import Foundation

// MARK: View

//RocketsViewInput
//RocketsDisplayLogic
protocol RocketsViewProtocol: AnyObject {
    func displayRockets(_ rockets: [RocketEntity])
    func displayError(_ error: Error)
}

// MARK: Presenter
//RocketsViewOutput
protocol RocketsPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didSelectRocket(at index: Int)
}

// MARK: Interactor
protocol RocketsInteractorInputProtocol: AnyObject {
    func fetchRockets()
}

protocol RocketsInteractorOutputProtocol: AnyObject {
    func didRetrieveRockets(_ rockets: [RocketEntity])
    func didFailToRetrieveRockets(withError error: Error)
}

// MARK: Router
protocol RocketsRouterProtocol: AnyObject {
    func navigateToLaunches(forRocket rocket: RocketEntity)
}
