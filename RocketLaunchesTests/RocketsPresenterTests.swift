//  RocketsPresenterTests.swift
//  RocketLaunchesTests
//
//  Created by Кирилл Васильев on 6.10.2023.
//

import XCTest  // Import XCTest framework for unit testing capabilities.
@testable import rocket_launches_programmatically  // Import your project module with testable access level to test internal components.

// Declare a test case class that inherits from XCTestCase.
final class RocketsPresenterTests: XCTestCase {
    
    // Declare variables for the presenter and mock implementations for the view and interactor.
    var sut: RocketsPresenter!
    var mockView: MockRocketsView!
    var mockInteractor: MockRocketsInteractor!

    // setUpWithError() is called before each test case runs.
    override func setUpWithError() throws {
        // Initialize the mock implementations and the presenter.
        mockView = MockRocketsView()
        mockInteractor = MockRocketsInteractor()
        sut = RocketsPresenter(view: mockView, interactor: mockInteractor)
    }

    // tearDownWithError() is called after each test case completes.
    override func tearDownWithError() throws {
        // Deallocate the objects to clean up resources.
        mockView = nil
        mockInteractor = nil
        sut = nil
    }

    // Existing default test example.
    func testExample() throws {
    }

    // Custom test to check if viewDidLoad calls fetchRockets.
    func testViewDidLoad() throws {
        sut.viewDidLoad()
        XCTAssertTrue(mockInteractor.fetchRocketsCalled, "fetchRockets should be called")
    }

    // Custom test to check if rockets are correctly retrieved.
    func testDidRetrieveRockets() throws {
        let rocket = RocketEntity(id: "1", name: "Falcon", heightMeters: 70.0, massKg: 5000)
        sut.didRetrieveRockets([rocket])
        XCTAssertTrue(mockView.displayRocketsCalled, "displayRockets should be called")
    }

    // Existing default performance test example.
    func testPerformanceExample() throws {
    }
}

// MARK: - Mock Classes

// Mock implementation for RocketsViewProtocol.
class MockRocketsView: RocketsViewProtocol {
    var displayRocketsCalled = false  // Flag to check if displayRockets was called.
    
    func displayRockets(_ rockets: [RocketEntity]) {
        displayRocketsCalled = true  // Set flag when method is called.
    }
    
    // Placeholder for other required methods.
    func displayError(_ error: Error) {}
}

// Mock implementation for RocketsInteractorInputProtocol.
class MockRocketsInteractor: RocketsInteractorInputProtocol {
    var fetchRocketsCalled = false  // Flag to check if fetchRockets was called.
    
    func fetchRockets() {
        fetchRocketsCalled = true  // Set flag when method is called.
    }
}
