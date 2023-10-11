//
//  RocketsViewControllerTests.swift
//  RocketLaunchesTests
//
//  Created by Кирилл Васильев on 7.10.2023.
//

import XCTest
@testable import rocket_launches_programmatically

final class RocketsViewControllerTests: XCTestCase {

    var sut: RocketsViewController!
    var mockPresenter: MockRocketsPresenter!

    override func setUpWithError() throws {
        mockPresenter = MockRocketsPresenter()
        sut = RocketsViewController()
        sut.setPresenter(mockPresenter)
        
        sut.loadViewIfNeeded() // Trigger viewDidLoad
    }

    override func tearDownWithError() throws {
        mockPresenter = nil
        sut = nil
    }

    func testViewControllerCallsPresenterOnViewDidLoad() {
        XCTAssertTrue(mockPresenter.viewDidLoadCalled)
    }
    
    func testTableViewSelectionCallsPresenterMethod() {
        let indexPath = IndexPath(row: 0, section: 0)
        sut.tableView(sut.tableView, didSelectRowAt: indexPath)
        XCTAssertTrue(mockPresenter.didSelectRocketCalled)
    }

    func testDisplayRocketsUpdatesTableView() {
        let rocket = RocketEntity(id: "1", name: "Rocket1", heightMeters: 70, massKg: 500) // Adapt this line
        let rockets = [rocket]
        
        sut.displayRockets(rockets)
        
        XCTAssertEqual((sut.tableView.dataSource?.tableView(sut.tableView, numberOfRowsInSection: 0))!, rockets.count)
    }
    
    func testPerformanceExample() throws {
        self.measure {
            // Insert performance measuring code here
        }
    }
}

// MARK: - Mock Classes

final class MockRocketsPresenter: RocketsPresenterProtocol {
    var viewDidLoadCalled = false
    var didSelectRocketCalled = false
    
    func viewDidLoad() {
        viewDidLoadCalled = true
    }
    
    func didSelectRocket(at index: Int) {
        didSelectRocketCalled = true
    }
    
    // Implement other methods from your RocketsPresenterProtocol
}
