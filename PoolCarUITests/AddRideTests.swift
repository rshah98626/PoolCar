//
//  AddRide.swift
//  PoolCarUITests
//
//  Created by Rahul Shah on 1/17/20.
//  Copyright © 2020 RSInc. All rights reserved.
//

import XCTest

class AddRideTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddRide() {

    }

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
}
