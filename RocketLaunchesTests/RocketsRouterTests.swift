//
//  RocketsRouterTests.swift
//  RocketLaunchesTests
//
//  Created by Кирилл Васильев on 7.10.2023.
//

import XCTest
@testable import rocket_launches_programmatically

final class RocketsRouterTests: XCTestCase {
    
    var sut: RocketsRouter!
    var mockViewController: MockViewController!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockViewController = MockViewController()
        sut = RocketsRouter()
        sut.viewController = mockViewController
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockViewController = nil
        sut = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testNavigateToLaunches() throws {
        let testRocket = RocketEntity(id: "1", name: "Falcon", heightMeters: 70.0, massKg: 5000)
        sut.navigateToLaunches(forRocket: testRocket)
        
        // Now, verify if the mockViewController's present method was called
                XCTAssertTrue(mockViewController.presentCalled, "ViewController's present method should be called")

        // Additional checks can go here, like checking if the correct viewController was instantiated,
        // if the modalPresentationStyle was set correctly, etc.

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

// MARK: - Mock Classes

class MockViewController: UIViewController {
    var presentCalled = false

    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentCalled = true  // Set the flag to true when this method is called

        // Optionally, you can add more logic here to inspect the 'viewControllerToPresent' object
    }
}
