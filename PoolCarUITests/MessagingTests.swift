//
//  MessagingTests.swift
//  PoolCarUITests
//
//  Created by Rahul Shah on 1/17/20.
//  Copyright © 2020 RSInc. All rights reserved.
//

import XCTest

class MessagingTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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

    func testChatLookAndFeel() {
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
        XCTAssertEqual(chatListItems.count, 2)

        let firstMessage = chatListItems.element(boundBy: 0)
        XCTAssertTrue(firstMessage.exists)
        XCTAssertEqual(firstMessage.descendants(matching: .staticText).element(boundBy: 0).label, "A")
        XCTAssertEqual(firstMessage.descendants(matching: .staticText).element(boundBy: 1).label, "Hello world")

        let secondMessage = chatListItems.element(boundBy: 1)
        XCTAssertTrue(secondMessage.exists)
        XCTAssertEqual(secondMessage.descendants(matching: .staticText).element(boundBy: 0).label, "B")
        XCTAssertEqual(secondMessage.descendants(matching: .staticText).element(boundBy: 1).label, "Hi")
    }

    func testChatKeyboardSlides() {
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
        let sendButton = app.buttons["Send"]
        let messageTextField = app.textFields["Message..."]
        XCTAssertTrue(sendButton.exists)
        XCTAssertTrue(messageTextField.exists)

        // verify compose message field and send button slide up when keyboard is shown
        let oldMessageTextFieldYPos = messageTextField.frame.origin.y
        let oldSendButtonYPos = sendButton.frame.origin.y
        messageTextField.tap()

        // wait for keyboard to show
        var expectation = XCTestExpectation(description: "Waiting for 1.5 seconds to let keyboard show")
        XCTWaiter().wait(for: [expectation], timeout: 1.5)
        XCTAssertTrue(oldMessageTextFieldYPos > messageTextField.frame.origin.y)
        XCTAssertTrue(oldSendButtonYPos > sendButton.frame.origin.y)

        // slide the keyboard down
        let keyboard = app.keyboards.element(boundBy: 0)
        keyboard.buttons["Return"].tap()

        // check that compose message field and send button return to original position
        expectation = XCTestExpectation(description: "Waiting for 1.5 seconds to let keyboard hide")
        XCTWaiter().wait(for: [expectation], timeout: 1.5)
        XCTAssertEqual(oldSendButtonYPos, sendButton.frame.origin.y)
        XCTAssertEqual(oldMessageTextFieldYPos, messageTextField.frame.origin.y)
    }

    func testChatSend() {
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

        // get chat send buttons
        let sendButton = app.buttons["Send"]
        let messageTextField = app.textFields["Message..."]
        XCTAssertTrue(sendButton.exists)
        XCTAssertTrue(messageTextField.exists)

        // verify messages
        let chatListItems = app.descendants(matching: .table).children(matching: .cell)
        let countBefore = chatListItems.count
        XCTAssertEqual(countBefore, 2)

        // wait for keyboard to show
        messageTextField.tap()
        var expectation = XCTestExpectation(description: "Waiting for 1 second to let keyboard show")
        XCTWaiter().wait(for: [expectation], timeout: 1)

        // compose a message and send it
        let keyboard = app.keyboards.element(boundBy: 0)
        keyboard.keys["R"].tap()
        keyboard.keys["a"].tap()
        keyboard.keys["h"].tap()
        keyboard.keys["u"].tap()
        keyboard.keys["l"].tap()
        keyboard.buttons["Return"].tap()

        // wait for keyboard to close
        expectation = XCTestExpectation(description: "Waiting for 1 second to let keyboard hide")
        XCTWaiter().wait(for: [expectation], timeout: 1)
        sendButton.tap()

        // verify message is properly sent
        let thirdMessage = chatListItems.element(boundBy: 2)
        XCTAssertEqual(chatListItems.count, countBefore + 1)
        XCTAssertTrue(thirdMessage.exists)
        XCTAssertEqual(thirdMessage.descendants(matching: .staticText).element(boundBy: 1).label, "C")
        XCTAssertEqual(thirdMessage.descendants(matching: .staticText).element(boundBy: 0).label, "Rahul")
    }
}
