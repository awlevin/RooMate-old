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
    
    func testApplication() {
        
        let app = XCUIApplication()
        app.buttons["Join Household"].tap()
        app.alerts["Where do you live?"].buttons["OK"].tap()
        
        let app2 = app
        app2.buttons["Statistics"].tap()
        app2.buttons["Debtors"].tap()
        app2.buttons["Debts"].tap()
        app.navigationBars["Finance"].buttons["Add"].tap()
        app.navigationBars["roomate.RMFinanceInvoiceView"].buttons["Cancel"].tap()
        app.tables["Total:, $0.00"].buttons["Remind All"].tap()
        
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Chore"].tap()
        app.navigationBars["Chore"].buttons["Add"].tap()
        app.navigationBars["roomate.RMChoreAddTypeView"].buttons["Cancel"].tap()
        tabBarsQuery.buttons["Shopping"].tap()
        app.navigationBars["Shopping"].buttons["Bookmarks"].tap()
        app.navigationBars["roomate.RMShoppingHistoryTableView"].buttons["Shopping"].tap()
        
        let bulletinBoardButton = tabBarsQuery.buttons["Bulletin Board"]
        bulletinBoardButton.tap()
        app.navigationBars["Bulletin Board"].buttons["Add"].tap()
        app.navigationBars["New Bulletin Post"].buttons["Bulletin Board"].tap()
        tabBarsQuery.buttons["Settings"].tap()
        bulletinBoardButton.tap()
        
    }
    
}
