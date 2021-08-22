//
//  GithubRecentsUITests.swift
//  GithubRecentsUITests
//
//  Created by Nick Hawryluk on 8/21/21.
//

import XCTest

class GithubRecentsUITests: XCTestCase {
    var app : XCUIApplication!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testUserInputViewControllerInputFields(){
        let app = XCUIApplication()
        
        app.textFields["GithubRecents"].tap()
        app.textFields["100"].tap()
        app.textFields["nick-havz"].tap()
        
        app/*@START_MENU_TOKEN@*/.staticTexts["FETCH!"]/*[[".buttons[\"FETCH!\"].staticTexts[\"FETCH!\"]",".staticTexts[\"FETCH!\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
}
