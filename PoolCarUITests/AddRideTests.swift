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

    // MARK: Adding a Ride Tests
    /// Tests that a new ride is added to the ride table
    // swiftlint:disable:next function_body_length
    func testAddRide() {
        let app = XCUIApplication()
        app.launch()

        // get navbar and table view
        let navbar = app.descendants(matching: .navigationBar).element(boundBy: 0)
        let listItems = app.descendants(matching: .table).children(matching: .cell)
        let trailingNavbarButton = navbar.buttons["car.fill"]
        let countBefore = listItems.count

        // go to add ride controller and wait for it to show
        trailingNavbarButton.tap()
        var expectation = XCTestExpectation(description: "Waiting for 2 seconds to let add ride modal appear")
        XCTWaiter().wait(for: [expectation], timeout: 2)

        // select an origin
        let originButton = app.buttons["Tap to select an origin!"]
        XCTAssertTrue(originButton.exists)
        originButton.tap()
        expectation = XCTestExpectation(description: "Waiting for 1 second to let place selector appear")
        XCTWaiter().wait(for: [expectation], timeout: 1)
        XCTAssertTrue(app.navigationBars["searchBar"].exists)

        // type in Naperville
        app.keys["N"].tap(); app.keys["a"].tap(); app.keys["p"].tap(); app.keys["e"].tap(); app.keys["r"].tap()
        app.keys["v"].tap(); app.keys["i"].tap(); app.keys["l"].tap(); app.keys["l"].tap(); app.keys["e"].tap()

        // tap first option in search results
        var selectedCell = app.tables.element(boundBy: 1).cells.element(boundBy: 0)
        XCTAssertTrue(selectedCell.exists)
        selectedCell.tap()

        // wait for google place modal to disappear and hit cancel
        expectation = XCTestExpectation(description: "Waiting for 1 second to let place selector disappear")
        XCTWaiter().wait(for: [expectation], timeout: 1)

        // select a destination
        let destinationButton = app.buttons["Tap to select a destination!"]
        XCTAssertTrue(destinationButton.exists)
        destinationButton.tap()
        expectation = XCTestExpectation(description: "Waiting for 1 second to let place selector appear")
        XCTWaiter().wait(for: [expectation], timeout: 1)
        XCTAssertTrue(app.navigationBars["searchBar"].exists)

        // type in Champaign
        app.keys["C"].tap(); app.keys["h"].tap(); app.keys["a"].tap(); app.keys["m"].tap(); app.keys["p"].tap()
        app.keys["a"].tap(); app.keys["i"].tap(); app.keys["g"].tap(); app.keys["n"].tap()

        // tap first option in search results
        selectedCell = app.tables.element(boundBy: 1).cells.element(boundBy: 0)
        XCTAssertTrue(selectedCell.exists)
        selectedCell.tap()

        // wait for google place modal to disappear and hit add
        expectation = XCTestExpectation(description: "Waiting for 1 second to let place selector disappear")
        XCTWaiter().wait(for: [expectation], timeout: 1)

        // verify origin and destination labels
        XCTAssertTrue(app.buttons["Naperville"].exists)
        XCTAssertTrue(app.buttons["Champaign"].exists)

        let addRide = app.buttons["Create Ride"]
        XCTAssertTrue(addRide.exists)
        addRide.tap()

        // test that number of cells are the same before and after
        XCTAssertEqual(countBefore + 1, app.descendants(matching: .table).children(matching: .cell).count)
    }

    // MARK: Cancel Ride Tests
    /// Tests that cancel button doesn't add a ride if an origin and destination  is selected
    // swiftlint:disable:next function_body_length
    func testCancelButtonAfterSelectingOriginAndDestination() {
        let app = XCUIApplication()
        app.launch()

        // get navbar and table view
        let navbar = app.descendants(matching: .navigationBar).element(boundBy: 0)
        let listItems = app.descendants(matching: .table).children(matching: .cell)
        let trailingNavbarButton = navbar.buttons["car.fill"]
        let countBefore = listItems.count

        // go to add ride controller and wait for it to show
        trailingNavbarButton.tap()
        var expectation = XCTestExpectation(description: "Waiting for 2 seconds to let add ride modal appear")
        XCTWaiter().wait(for: [expectation], timeout: 2)

        // select an origin
        let originButton = app.buttons["Tap to select an origin!"]
        XCTAssertTrue(originButton.exists)
        originButton.tap()
        expectation = XCTestExpectation(description: "Waiting for 1 second to let place selector appear")
        XCTWaiter().wait(for: [expectation], timeout: 1)
        XCTAssertTrue(app.navigationBars["searchBar"].exists)

        // type in Naperville
        app.keys["N"].tap(); app.keys["a"].tap(); app.keys["p"].tap(); app.keys["e"].tap(); app.keys["r"].tap()
        app.keys["v"].tap(); app.keys["i"].tap(); app.keys["l"].tap(); app.keys["l"].tap(); app.keys["e"].tap()

        // tap first option in search results
        var selectedCell = app.tables.element(boundBy: 1).cells.element(boundBy: 0)
        XCTAssertTrue(selectedCell.exists)
        selectedCell.tap()

        // wait for google place modal to disappear and hit cancel
        expectation = XCTestExpectation(description: "Waiting for 1 second to let place selector disappear")
        XCTWaiter().wait(for: [expectation], timeout: 1)

        // select a destination
        let destinationButton = app.buttons["Tap to select a destination!"]
        XCTAssertTrue(destinationButton.exists)
        destinationButton.tap()
        expectation = XCTestExpectation(description: "Waiting for 1 second to let place selector appear")
        XCTWaiter().wait(for: [expectation], timeout: 1)
        XCTAssertTrue(app.navigationBars["searchBar"].exists)

        // type in Champaign
        app.keys["C"].tap(); app.keys["h"].tap(); app.keys["a"].tap(); app.keys["m"].tap(); app.keys["p"].tap()
        app.keys["a"].tap(); app.keys["i"].tap(); app.keys["g"].tap(); app.keys["n"].tap()

        // tap first option in search results
        selectedCell = app.tables.element(boundBy: 1).cells.element(boundBy: 0)
        XCTAssertTrue(selectedCell.exists)
        selectedCell.tap()

        // wait for google place modal to disappear and hit cancel
        expectation = XCTestExpectation(description: "Waiting for 1 second to let place selector disappear")
        XCTWaiter().wait(for: [expectation], timeout: 1)

        // verify create ride button is enabled
        XCTAssertTrue(app.buttons["Create Ride"].exists)
        XCTAssertTrue(app.buttons["Create Ride"].isEnabled)

        let cancelButton = app.buttons["Cancel"]
        XCTAssertTrue(cancelButton.exists)
        cancelButton.tap()

        // test that number of cells are the same before and after
        XCTAssertEqual(countBefore, app.descendants(matching: .table).children(matching: .cell).count)
    }

    /// Tests that cancel button doesn't add a ride if an origin is selected
    func testCancelButtonAfterSelectingOrigin() {
        let app = XCUIApplication()
        app.launch()

        // get navbar and table view
        let navbar = app.descendants(matching: .navigationBar).element(boundBy: 0)
        let listItems = app.descendants(matching: .table).children(matching: .cell)
        let trailingNavbarButton = navbar.buttons["car.fill"]
        let countBefore = listItems.count

        // go to add ride controller and wait for it to show
        trailingNavbarButton.tap()
        var expectation = XCTestExpectation(description: "Waiting for 2 seconds to let add ride modal appear")
        XCTWaiter().wait(for: [expectation], timeout: 2)

        // select a location
        let originButton = app.buttons["Tap to select an origin!"]
        XCTAssertTrue(originButton.exists)
        originButton.tap()
        expectation = XCTestExpectation(description: "Waiting for 1 second to let place selector appear")
        XCTWaiter().wait(for: [expectation], timeout: 1)
        XCTAssertTrue(app.navigationBars["searchBar"].exists)

        // type in Naperville
        app.keys["N"].tap(); app.keys["a"].tap(); app.keys["p"].tap(); app.keys["e"].tap(); app.keys["r"].tap()
        app.keys["v"].tap(); app.keys["i"].tap(); app.keys["l"].tap(); app.keys["l"].tap(); app.keys["e"].tap()

        // tap first option in search results
        let selectedCell = app.tables.element(boundBy: 1).cells.element(boundBy: 0)
        XCTAssertTrue(selectedCell.exists)
        selectedCell.tap()

        // wait for google place modal to disappear and hit cancel
        expectation = XCTestExpectation(description: "Waiting for 1 second to let place selector disappear")
        XCTWaiter().wait(for: [expectation], timeout: 1)

        // verify create ride button is disabled
        XCTAssertTrue(app.buttons["Create Ride"].exists)
        XCTAssertFalse(app.buttons["Create Ride"].isEnabled)

        let cancelButton = app.buttons["Cancel"]
        XCTAssertTrue(cancelButton.exists)
        cancelButton.tap()

        // test that number of cells are the same before and after
        XCTAssertEqual(countBefore, app.descendants(matching: .table).children(matching: .cell).count)
    }

    /// Tests cancel button functionality
    func testCancelButton() {
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

        // verify create ride button is disabled
        XCTAssertTrue(app.buttons["Create Ride"].exists)
        XCTAssertFalse(app.buttons["Create Ride"].isEnabled)

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

    // MARK: Date Picker Tests
    /// Tests that dates in the past are not able to be selected
    // NOTE: this test may have to be run more than one time, due to the nature of comparing times
    func testDatePickerPastValues() {
        let app = XCUIApplication()
        app.launch()

        // get navbar
        let navbar = app.descendants(matching: .navigationBar).element(boundBy: 0)
        let trailingNavbarButton = navbar.buttons["car.fill"]

        // go to add ride controller and wait for it to show
        trailingNavbarButton.tap()
        let expectation = XCTestExpectation(description: "Waiting for 2 seconds to let add ride modal appear")
        XCTWaiter().wait(for: [expectation], timeout: 2)

        // get individual picker objects
        let datePicker = app.datePickers["Departure Time"].pickers.pickerWheels.element(boundBy: 0)
        let hourPicker = app.datePickers["Departure Time"].pickers.pickerWheels.element(boundBy: 1)
        let minutePicker = app.datePickers["Departure Time"].pickers.pickerWheels.element(boundBy: 2)
        let daytimePicker = app.datePickers["Departure Time"].pickers.pickerWheels.element(boundBy: 3)

        XCTAssertTrue(datePicker.exists)
        XCTAssertTrue(hourPicker.exists)
        XCTAssertTrue(minutePicker.exists)
        XCTAssertTrue(daytimePicker.exists)

        // init formatter and a past date one day, one hour, and one minute in the past
        let formatter = DateFormatter()
        let yesterday = getPastDate(amPm: false)

        // use formatter to modify pickers and verify output is correct
        formatter.dateFormat = "MMM d"
        let monthText = formatter.string(from: yesterday)
        datePicker.adjust(toPickerWheelValue: monthText)
        // NOTE: we do not set UI Labels, hence the 'Optional'
        XCTAssertEqual(datePicker.value.debugDescription, "Optional(Today)")

        formatter.dateFormat = "h"
        let hourText = formatter.string(from: yesterday)
        hourPicker.adjust(toPickerWheelValue: hourText)
        XCTAssertEqual(hourPicker.value.debugDescription, "Optional(" + formatter.string(from: Date()) + " o’clock)")

        formatter.dateFormat = "mm"
        let minuteText = formatter.string(from: yesterday)
        minutePicker.adjust(toPickerWheelValue: minuteText)
        XCTAssertEqual(minutePicker.value.debugDescription, "Optional(" + formatter.string(from: Date()) + " minutes)")

        formatter.dateFormat = "a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        let daytimeText = formatter.string(from: getPastDate(amPm: true))
        daytimePicker.adjust(toPickerWheelValue: daytimeText)
        XCTAssertEqual(daytimePicker.value.debugDescription, "Optional(" + formatter.string(from: Date()) + ")")
    }

    /// Helper which gets a Date object in the past. Used in conjuction with testDatePickerPastValues()
    func getPastDate(amPm: Bool) -> Date {
        var dateComponents = DateComponents()

        if amPm {
            dateComponents.setValue(-12, for: .hour)
        } else {
            dateComponents.setValue(-1, for: .day)
            dateComponents.setValue(-1, for: .hour)
            dateComponents.setValue(-1, for: .minute)
        }

        let now = Date() // Current date
        let yesterday = Calendar.current.date(byAdding: dateComponents, to: now) // Add the DateComponents

        return yesterday!
    }
}
