//
//  UITests.swift
//  roomate
//
//  Created by Ritvik Upadhyaya on 23/11/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import XCTest

class UITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        
        let app = XCUIApplication()
        app.buttons["Join Household"].tap()
        app.alerts["Where do you live?"].buttons["OK"].tap()
        
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Chore"].tap()
        tabBarsQuery.buttons["Shopping"].tap()
        
        let bulletinBoardButton = tabBarsQuery.buttons["Bulletin Board"]
        bulletinBoardButton.tap()
        tabBarsQuery.buttons["Settings"].tap()
        bulletinBoardButton.tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element
        element.swipeLeft()
        element.tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
    }
    
}
