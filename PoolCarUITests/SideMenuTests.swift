//
//  SideMenuTests.swift
//  PoolCarUITests
//
//  Created by Rahul Shah on 1/17/20.
//  Copyright © 2020 RSInc. All rights reserved.
//

import XCTest

class SideMenuTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSideMenu() {
        let app = XCUIApplication()
        app.launch()

        // get navbar and table view
        let navbar = app.descendants(matching: .navigationBar).element(boundBy: 0)
        let sideMenuButton = navbar.buttons["gear"]
        XCTAssertTrue(sideMenuButton.exists)

        // verify side menu options exist and are hidden
        XCTAssertTrue(app.staticTexts["My Profile"].exists)
        XCTAssertTrue(app.staticTexts["Settings"].exists)
        XCTAssertTrue(app.staticTexts["Past Rides"].exists)

        let myProfileXBefore = app.staticTexts["My Profile"].frame.origin.x
        let settingsXBefore = app.staticTexts["Settings"].frame.origin.x
        let pastRidesXBefore = app.staticTexts["Past Rides"].frame.origin.x
        XCTAssertTrue(myProfileXBefore < 0.0)
        XCTAssertTrue(settingsXBefore < 0.0)
        XCTAssertTrue(pastRidesXBefore < 0.0)

        // access side menu
        sideMenuButton.tap()

        // wait for side menu to appear
        let expectation = XCTestExpectation(description: "Waiting for 2 seconds to let menu appear")
        XCTWaiter().wait(for: [expectation], timeout: 2)

        // verify content of side menu
        let myProfileXAfter = app.staticTexts["My Profile"].frame.origin.x
        let settingsXAfter = app.staticTexts["Settings"].frame.origin.x
        let pastRidesXAfter = app.staticTexts["Past Rides"].frame.origin.x
        XCTAssertTrue(myProfileXAfter >= 0.0)
        XCTAssertTrue(settingsXAfter >= 0.0)
        XCTAssertTrue(pastRidesXAfter >= 0.0)

        // head back to ride table view and verify menu options are hidden
        app.buttons["car.fill"].tap()
        XCTAssertEqual(myProfileXBefore, app.staticTexts["My Profile"].frame.origin.x)
        XCTAssertEqual(settingsXBefore, app.staticTexts["Settings"].frame.origin.x)
        XCTAssertEqual(pastRidesXBefore, app.staticTexts["Past Rides"].frame.origin.x)
    }
}
