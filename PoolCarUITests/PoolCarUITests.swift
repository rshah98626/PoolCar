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

    func testHideChat() {
        let app = XCUIApplication()
        app.launch()

        // get table view and click on first cell
        let listItems = app.descendants(matching: .table).children(matching: .cell)
        let firstRideCell = listItems.element(boundBy: 0).descendants(matching: .button).element
        firstRideCell.tap()

        // go to chat view
        let showChatButton = app.buttons["Show Chat"]
        XCTAssertTrue(showChatButton.exists)
        showChatButton.tap()

        // hide chat and count the number of messages
        let hideChatButton = app.buttons["Close Chat"]
        XCTAssertTrue(hideChatButton.exists)
        let chatListItems = app.descendants(matching: .table).children(matching: .cell)
        let countMessagesBefore = chatListItems.count

        // close and reopen chat to verify the same number of messages
        hideChatButton.tap()
        showChatButton.tap()
        XCTAssertEqual(countMessagesBefore, app.descendants(matching: .table).children(matching: .cell).count)
    }

    func testChat() {
        let app = XCUIApplication()
        app.launch()

        // get table view and click on first cell
        let listItems = app.descendants(matching: .table).children(matching: .cell)
        let firstRideCell = listItems.element(boundBy: 0).descendants(matching: .button).element
        firstRideCell.tap()

        // go to chat view
        let showChatButton = app.buttons["Show Chat"]
        XCTAssertTrue(showChatButton.exists)
        showChatButton.tap()

        // verify chat components
        let hideChatButton = app.buttons["Close Chat"]
        let sendButton = app.buttons["Send"]
        let messageTextField = app.textFields["Message..."]
        XCTAssertTrue(hideChatButton.exists)
        XCTAssertTrue(sendButton.exists)
        XCTAssertTrue(messageTextField.exists)

        // verify messages
        let chatListItems = app.descendants(matching: .table).children(matching: .cell)
        let countBefore = chatListItems.count
        XCTAssertEqual(countBefore, 2)

        let firstMessage = chatListItems.element(boundBy: 0)
        XCTAssertTrue(firstMessage.exists)
        XCTAssertEqual(firstMessage.descendants(matching: .staticText).element(boundBy: 0).label, "A")
        XCTAssertEqual(firstMessage.descendants(matching: .staticText).element(boundBy: 1).label, "Hello world")

        let secondMessage = chatListItems.element(boundBy: 1)
        XCTAssertTrue(secondMessage.exists)
        XCTAssertEqual(secondMessage.descendants(matching: .staticText).element(boundBy: 0).label, "B")
        XCTAssertEqual(secondMessage.descendants(matching: .staticText).element(boundBy: 1).label, "Hi")

        // verify compose message field and send button slide up when keyboard is shown
        let oldMessageTextFieldYPos = messageTextField.frame.origin.y
        let oldSendButtonYPos = sendButton.frame.origin.y
        messageTextField.tap()

        // wait for keyboard to show
        var expectation = XCTestExpectation(description: "Waiting for 1 second to let keyboard show")
        XCTWaiter().wait(for: [expectation], timeout: 1)
        XCTAssertTrue(oldMessageTextFieldYPos > messageTextField.frame.origin.y)
        XCTAssertTrue(oldSendButtonYPos > sendButton.frame.origin.y)

        // compose a message and send it
        let keyboard = app.keyboards.element(boundBy: 0)
        keyboard.keys["R"].tap()
        keyboard.keys["a"].tap()
        keyboard.keys["h"].tap()
        keyboard.keys["u"].tap()
        keyboard.keys["l"].tap()
        keyboard.buttons["Return"].tap()

        // check that compose message field and send button return to original position
        expectation = XCTestExpectation(description: "Waiting for 1 second to let keyboard hide")
        XCTWaiter().wait(for: [expectation], timeout: 1)
        XCTAssertEqual(oldSendButtonYPos, sendButton.frame.origin.y)
        XCTAssertEqual(oldMessageTextFieldYPos, messageTextField.frame.origin.y)
        sendButton.tap()

        // verify message is properly sent
        let thirdMessage = chatListItems.element(boundBy: 2)
        XCTAssertEqual(chatListItems.count, countBefore + 1)
        XCTAssertTrue(thirdMessage.exists)
        XCTAssertEqual(thirdMessage.descendants(matching: .staticText).element(boundBy: 1).label, "C")
        XCTAssertEqual(thirdMessage.descendants(matching: .staticText).element(boundBy: 0).label, "Rahul")
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
