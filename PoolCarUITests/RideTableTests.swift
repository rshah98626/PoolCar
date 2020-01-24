//
//  RideTableTests.swift
//  PoolCarUITests
//
//  Created by Rahul Shah on 1/17/20.
//  Copyright © 2020 RSInc. All rights reserved.
//

import XCTest

class RideTableTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /// Tests that the ride table's look and feel is correct
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

    /// Tests tapping on a ride cell and the look of a detailed view
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
}
