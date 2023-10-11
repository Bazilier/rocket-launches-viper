////
////  LaunchesProtocols.swift
////  rocket-launches-programmatically
////
////  Created by Кирилл Васильев on 5.10.2023.
////
//
import Foundation

// MARK: View
protocol LaunchesViewProtocol: AnyObject {
    func displayLaunches(upcoming: [LaunchEntity], past: [LaunchEntity])
    func displayError(_ error: Error)
}


// MARK: Presenter
protocol LaunchesPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didSelectLaunch(at index: Int)
}

// MARK: Interactor
protocol LaunchesInteractorInputProtocol: AnyObject {
    func fetchLaunches()
}

protocol LaunchesInteractorOutputProtocol: AnyObject {
    func didRetrieveLaunches(upcoming: [LaunchEntity], past: [LaunchEntity])
    
    func didFailToFetchLaunches(error: Error)
}

// MARK: Router
protocol LaunchesRouterProtocol: AnyObject {
    func navigateToSomewhere(forRocket rocket: LaunchEntity)
}
