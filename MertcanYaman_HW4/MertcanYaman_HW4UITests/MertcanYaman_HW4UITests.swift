//
//  MertcanYaman_HW4UITests.swift
//  MertcanYaman_HW4UITests
//
//  Created by mertcan YAMAN on 6.06.2023.
//

import XCTest

final class MertcanYaman_HW4UITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("********* UI Test *************")
    }
    
    func test_search_from_home_view_controller() {
        app.launch()
        app.searchTextField.tap()
        app.keys["a"].tap()
        app.keys["b"].tap()
        app.keys["c"].tap()
    }
    
}

extension XCUIApplication {
    
    var searchTextField: XCUIElement! {
        textFields["searchTextField"]
    }
    
    var tableViewFromHome: XCUIElement! {
        tables["tableViewFromHome"]
    }
    
    var searchTextFieldDisplayed: Bool {
        searchTextField.exists
    }
    
    var tableViewFromHomeDisplayed: Bool {
        tableViewFromHome.exists
    }
    
}
