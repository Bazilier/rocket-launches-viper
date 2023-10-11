//
//  LaunchesInteractor.swift
//  rocket-launches-programmatically
//
//  Created by Кирилл Васильев on 12.08.2023.
//

import Foundation
import SpaceXAPI

class LaunchesInteractor: LaunchesInteractorInputProtocol {
    weak var output: LaunchesInteractorOutputProtocol?
    
    var rocket: RocketEntity // Assuming RocketEntity is defined elsewhere
    var launchesUpcoming: [LaunchEntity] = []
    var launchesPast: [LaunchEntity] = []
    
    init(rocket: RocketEntity) {
        self.rocket = rocket
    }

    func fetchLaunches() {
        print("fetchLaunches() started")
        let launchFind = LaunchFind(rocket_id: rocket.id ?? .none)
        let query = LaunchesQuery(upcomingFind: .some(launchFind), pastFind: .some(launchFind))
        
        print(rocket.id, launchFind)
        
        NetworkService.shared.apollo.fetch(query: query) { [weak self] result in
            print("Network fetch completed")
            
            guard let self = self else { return }
            
            switch result {
            case .success(let value):
                print("Network fetch succeeded")
                
                self.launchesUpcoming = value.data?.launchesUpcoming?.compactMap {
                    guard let launch = $0 else { return nil }
                    print("Mapping upcoming launch: \(String(describing: launch.id))")
                    return LaunchEntity(id: launch.id ?? "", missionName: launch.mission_name ?? "", launchDateUTC: launch.launch_date_utc ?? "")
                } ?? []
                
                self.launchesPast = value.data?.launchesPast?.compactMap {
                    guard let launch = $0 else { return nil }
                    print("Mapping past launch: \(String(describing: launch.id))")
                    return LaunchEntity(id: launch.id ?? "", missionName: launch.mission_name ?? "", launchDateUTC: launch.launch_date_utc ?? "")
                } ?? []
                
                print(self.launchesPast, self.launchesUpcoming)
                
                print(self.output)
                
                self.output?.didRetrieveLaunches(upcoming: self.launchesUpcoming , past: self.launchesPast)
                
            case .failure(let error):
                print("Network fetch failed with error: \(error)")
                self.output?.didFailToFetchLaunches(error: error)
            }
        }
    }
}
