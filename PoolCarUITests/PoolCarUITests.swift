//
//  PoolCarUITests.swift
//  PoolCarUITests
//
//  Created by Rahul Shah on 12/25/19.
//  Copyright © 2019 RSInc. All rights reserved.
//

// NOTE: Use element.debugDescription to see view hierarchy

import XCTest

class PoolCarUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation -
        // required for your tests before they run. The
        // setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRideTable() {
        let app = XCUIApplication()
        app.launch()

        // get navbar and table view
        let navbar = app.descendants(matching: .navigationBar).element(boundBy: 0)
        let listItems = app.descendants(matching: .table).children(matching: .cell)

        // test navbar content
        let leadingNavbarButton = navbar.buttons["gear"]
        let trailingNavbarButton = navbar.buttons["car.fill"]
        let rideLabel = navbar.staticTexts["Rides"]
        XCTAssertTrue(leadingNavbarButton.exists)
        XCTAssertTrue(trailingNavbarButton.exists)
        XCTAssertTrue(rideLabel.exists)

        // test that cells exist and labels are correct
        let firstRideCell = listItems.element(boundBy: 0).descendants(matching: .button).element
        let secondRideCell = listItems.element(boundBy: 1).descendants(matching: .button).element
        XCTAssertTrue(firstRideCell.exists)
        XCTAssertTrue(secondRideCell.exists)
        XCTAssertTrue(firstRideCell.label == "Naperville\nChampaign")
        XCTAssertTrue(secondRideCell.label == "Mount Prospect\nChampaign")
    }

    func testDetail() {
        let app = XCUIApplication()
        app.launch()

        // get navbar and table view
        let navbar = app.descendants(matching: .navigationBar).element(boundBy: 0)
        let listItems = app.descendants(matching: .table).children(matching: .cell)
        let countBefore = listItems.count

        // go to detailed view and verify content
        let firstRideCell = listItems.element(boundBy: 0).descendants(matching: .button).element
        firstRideCell.tap()
        XCTAssertTrue(app.descendants(matching: .staticText)
            .element(matching: .staticText, identifier: "From: Naperville").exists)
        XCTAssertTrue(app.descendants(matching: .staticText)
            .element(matching: .staticText, identifier: "To: Champaign").exists)
        XCTAssertTrue(app.descendants(matching: .staticText)
            .element(matching: .staticText, identifier: "Price: $25.0").exists)
        XCTAssertTrue(app.descendants(matching: .button)
            .element(matching: .button, identifier: "Show Chat").exists)
        XCTAssertFalse(app.descendants(matching: .staticText)
            .element(matching: .staticText, identifier: "From: Mount Prospect").exists)

        // check back button exists and leads to table view
        let backButton = navbar.buttons["Rides"]
        let rideLabel = navbar.staticTexts["Rides"]
        let leadingNavbarButton = navbar.buttons["gear"]
        let trailingNavbarButton = navbar.buttons["car.fill"]
        XCTAssertTrue(backButton.exists)
        XCTAssertFalse(rideLabel.exists)
        XCTAssertFalse(leadingNavbarButton.exists)
        XCTAssertFalse(trailingNavbarButton.exists)

        // head back to home view and verify view is not changed
        backButton.tap()
        let countAfter = listItems.count
        XCTAssertEqual(countBefore, countAfter)
        XCTAssertTrue(leadingNavbarButton.exists)
        XCTAssertTrue(trailingNavbarButton.exists)
        XCTAssertTrue(rideLabel.exists)
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

//    func testAddRide() {
//
//    }

    func testCancelAddRide() {
        let app = XCUIApplication()
        app.launch()

        // get navbar and table view
        let navbar = app.descendants(matching: .navigationBar).element(boundBy: 0)
        let listItems = app.descendants(matching: .table).children(matching: .cell)
        let trailingNavbarButton = navbar.buttons["car.fill"]
        let countBefore = listItems.count

        // go to add ride controller and wait for it to show
        trailingNavbarButton.tap()
        let expectation = XCTestExpectation(description: "Waiting for 2 seconds to let add ride modal appear")
        XCTWaiter().wait(for: [expectation], timeout: 2)

        // hit cancel
        let cancelButton = app.buttons["Cancel"]
        XCTAssertTrue(cancelButton.exists)
        cancelButton.tap()

        // test navbar content
        let leadingNavbarButton = navbar.buttons["gear"]
        let rideLabel = navbar.staticTexts["Rides"]
        XCTAssertTrue(leadingNavbarButton.exists)
        XCTAssertTrue(trailingNavbarButton.exists)
        XCTAssertTrue(rideLabel.exists)

        // test that cells exist and labels are correct
        XCTAssertEqual(countBefore, app.descendants(matching: .table).children(matching: .cell).count)
        let firstRideCell = listItems.element(boundBy: 0).descendants(matching: .button).element
        let secondRideCell = listItems.element(boundBy: 1).descendants(matching: .button).element
        XCTAssertTrue(firstRideCell.exists)
        XCTAssertTrue(secondRideCell.exists)
        XCTAssertTrue(firstRideCell.label == "Naperville\nChampaign")
        XCTAssertTrue(secondRideCell.label == "Mount Prospect\nChampaign")
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
