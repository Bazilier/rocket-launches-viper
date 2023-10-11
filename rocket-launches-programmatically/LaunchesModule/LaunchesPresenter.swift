//
//  LaunchesPresenter.swift
//  rocket-launches-programmatically
//
//  Created by Кирилл Васильев on 12.08.2023.
//

import Foundation

class LaunchesPresenter: LaunchesPresenterProtocol, LaunchesInteractorOutputProtocol {
    weak var view: LaunchesViewProtocol?
    var interactor: LaunchesInteractorInputProtocol?
    var router: LaunchesRouterProtocol?
    
    
    func viewDidLoad() {
        print("In viewDidLoad of presenter. Interactor is \(String(describing: interactor))")
        interactor?.fetchLaunches()
    }
    
    func didSelectLaunch(at index: Int) {
    }
    
    // Assuming LaunchesInteractorOutputProtocol has this method
    func didRetrieveLaunches(upcoming: [LaunchEntity], past: [LaunchEntity]) {
        print("Presenter did retrieve launches. Informing view.")
        print(upcoming, past)
        view?.displayLaunches(upcoming: upcoming, past: past)
    }
    
    // Assuming LaunchesInteractorOutputProtocol has this method
    func didFailToFetchLaunches(error: Error) {
        // Handle error
        view?.displayError(error)
    }
}
