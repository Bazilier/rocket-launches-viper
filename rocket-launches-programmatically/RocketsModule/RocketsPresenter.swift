//
//  RocketsPresenter.swift
//  rocket-launches-programmatically
//
//  Created by Кирилл Васильев on 12.08.2023.
//

import Foundation

class RocketsPresenter: RocketsPresenterProtocol, RocketsInteractorOutputProtocol {

    weak var view: RocketsViewProtocol?
    var interactor: RocketsInteractorInputProtocol?
    var router: RocketsRouterProtocol?
    
    var rocketList: [RocketEntity] = []
    
    init(view: RocketsViewProtocol, interactor: RocketsInteractorInputProtocol) {
        self.view = view
        self.interactor = interactor
    }
    
    func didSelectRocket(at index: Int) {
        print("didSelectRocket was called with index: \(index)")
        print("Current rocketList: \(rocketList)")
        if index < rocketList.count {
            let selectedRocket = rocketList[index]
            print("About to call navigateToLaunches in Router")
            router?.navigateToLaunches(forRocket: selectedRocket)
        }
    }
    
    /// Invoked when the view is loaded, initiating rocket data fetching.
    func viewDidLoad() {
        interactor?.fetchRockets()
    }
    
    /// Process and sends the fetched rocket data to the view for display.
    func didRetrieveRockets(_ rockets: [RocketEntity]) {
        print("Rockets fetched: \(rockets)")  // Debug line
        self.rocketList = rockets  // Make sure this line exists
        view?.displayRockets(rockets)
    }
    
    /// Sends an error to the view in case data fetching fails.
    func didFailToRetrieveRockets(withError error: Error) {
        view?.displayError(error)
    }
}


