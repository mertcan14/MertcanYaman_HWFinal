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
        
        XCTAssertTrue(app.searchTextFieldDisplayed)
        XCTAssertTrue(app.tableViewFromHomeDisplayed)

        app.tabBars["Tab Bar"].buttons["Play List"].tap()
        
        XCTAssertTrue(app.buttons["Add Play List"].exists)
        app.buttons["Add Play List"].tap()
        
        XCTAssertTrue(app.playListTextFieldDisplayed)
        
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        elementsQuery.textFields["playListTextField"].tap()
        
        elementsQuery.textFields["playListTextField"].typeText("PlayListName")
        
        XCTAssertEqual(app.playListTextField.value as? String, "PlayListName")
        
        app.keyboards.buttons["Return"].tap()

        elementsQuery.buttons["Save"].tap()
        
        app.tabBars["Tab Bar"].buttons["Home"].tap()
        
        XCTAssertTrue(app.searchTextFieldDisplayed)
        XCTAssertTrue(app.tableViewFromHomeDisplayed)
        XCTAssertFalse(app.playListTextFieldDisplayed)
        
        app.searchTextField.tap()
        app.searchTextField.typeText("Tarkan")
        
        XCTAssertEqual(app.searchTextField.value as? String, "Tarkan")
        
    }
    
    func dismissKeyboardIfPresent() {
        if app.keyboards.element(boundBy: 0).exists {
            if UIDevice.current.userInterfaceIdiom == .pad {
                app.keyboards.buttons["Hide keyboard"].tap()
            } else {
                app.toolbars.buttons["Done"].tap()
            }
        }
    }
}

extension XCUIApplication {
    
    var searchTextField: XCUIElement! {
        searchFields["searchTextField"]
    }
    
    var playListTextField: XCUIElement! {
        textFields["playListTextField"]
    }
    
    var tableViewFromHome: XCUIElement! {
        tables["tableViewFromHome"]
    }
    
    var searchTextFieldDisplayed: Bool {
        searchTextField.exists
    }
    
    var playListTextFieldDisplayed: Bool {
        playListTextField.exists
    }
    
    var tableViewFromHomeDisplayed: Bool {
        tableViewFromHome.exists
    }
    
}
