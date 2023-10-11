//
//  RocketsInteractor.swift
//  rocket-launches-programmatically
//
//  Created by Кирилл Васильев on 12.08.2023.
//

import Foundation
import SpaceXAPI

class RocketsInteractor: RocketsInteractorInputProtocol {
    weak var output: RocketsInteractorOutputProtocol?
    
    
    
    func fetchRockets() {
        let query = RocketsQuery()
        NetworkService.shared.apollo.fetch(query: query) { [weak self] result in
            switch result {
            case .success(let value):
                let rockets = value.data?.rockets?.compactMap { rocket -> RocketEntity? in
                    guard let rocket = rocket else { return nil }
                    let id = rocket.id ?? "Unknown ID"
                    let name = rocket.name ?? "Unknown Rocket"
                    let heightMeters = rocket.height?.meters ?? 0
                    let massKg = rocket.mass?.kg ?? 0
                    return RocketEntity(id: id, name: name, heightMeters: heightMeters, massKg: massKg)
                } ?? []
                self?.output?.didRetrieveRockets(rockets)
            case .failure(let error):
                self?.output?.didFailToRetrieveRockets(withError: error)
            }
        }
    }
}

