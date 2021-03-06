//
//  ContactsUITests.swift
//  ContactsUITests
//
//  Created by Yang Liu on 2/20/20.
//  Copyright © 2020 Yang Liu. All rights reserved.
//

import XCTest

class ContactsUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func waitForElementToAppear(_ element: XCUIElement) -> Bool {
        let myPredicate = NSPredicate(format: "exists == true")
        let myExpectation = expectation(for: myPredicate, evaluatedWith: element, handler: nil)
        let result = XCTWaiter().wait(for: [myExpectation], timeout: 5)
        return result == .completed
    }

    func testTappingOnProfileImage() {
        let app = XCUIApplication()
        app.launchArguments.append("--UITest")
        app.launch()
        
        let profileImageCollectionView = app.collectionViews["profile image collection view"]
        let profileInformationCollectionView = app.collectionViews["profile information collection view"]
    XCTAssertTrue(waitForElementToAppear(profileInformationCollectionView/*@START_MENU_TOKEN@*/.staticTexts["Allan Munger"]/*[[".cells[\"profile information cell at 0\"].staticTexts[\"Allan Munger\"]",".staticTexts[\"Allan Munger\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/))
        
        profileImageCollectionView.cells["profile image cell at 1"].tap()
        XCTAssertTrue(waitForElementToAppear(profileInformationCollectionView.staticTexts["Amanda Brady"]))
        
        profileImageCollectionView.cells["profile image cell at 2"].tap()
        XCTAssertTrue(waitForElementToAppear(profileInformationCollectionView/*@START_MENU_TOKEN@*/.staticTexts["Ashley Mc Carthy"]/*[[".cells[\"profile information cell at 2\"].staticTexts[\"Ashley Mc Carthy\"]",".staticTexts[\"Ashley Mc Carthy\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/))
        
        profileImageCollectionView.cells["profile image cell at 3"].tap()
        XCTAssertTrue(waitForElementToAppear(profileInformationCollectionView/*@START_MENU_TOKEN@*/.staticTexts["Carlos Slattery"]/*[[".cells[\"profile information cell at 3\"].staticTexts[\"Carlos Slattery\"]",".staticTexts[\"Carlos Slattery\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/))
        
        profileImageCollectionView.cells["profile image cell at 4"].tap()
        XCTAssertTrue(waitForElementToAppear(profileInformationCollectionView/*@START_MENU_TOKEN@*/.staticTexts["Carole Poland"]/*[[".cells[\"profile information cell at 4\"].staticTexts[\"Carole Poland\"]",".staticTexts[\"Carole Poland\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/))
        
        profileImageCollectionView.cells["profile image cell at 3"].tap()
        XCTAssertTrue(waitForElementToAppear(profileInformationCollectionView/*@START_MENU_TOKEN@*/.staticTexts["Carlos Slattery"]/*[[".cells[\"profile information cell at 3\"].staticTexts[\"Carlos Slattery\"]",".staticTexts[\"Carlos Slattery\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/))
        
        profileImageCollectionView.cells["profile image cell at 2"].tap()
        XCTAssertTrue(waitForElementToAppear(profileInformationCollectionView/*@START_MENU_TOKEN@*/.staticTexts["Ashley Mc Carthy"]/*[[".cells[\"profile information cell at 2\"].staticTexts[\"Ashley Mc Carthy\"]",".staticTexts[\"Ashley Mc Carthy\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/))
        
        profileImageCollectionView.cells["profile image cell at 1"].tap()
        XCTAssertTrue(waitForElementToAppear(profileInformationCollectionView/*@START_MENU_TOKEN@*/.staticTexts["Amanda Brady"]/*[[".cells[\"profile information cell at 1\"].staticTexts[\"Amanda Brady\"]",".staticTexts[\"Amanda Brady\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/))

        profileImageCollectionView.cells["profile image cell at 0"].tap()
        XCTAssertTrue(waitForElementToAppear(profileInformationCollectionView/*@START_MENU_TOKEN@*/.staticTexts["Allan Munger"]/*[[".cells[\"profile information cell at 0\"].staticTexts[\"Allan Munger\"]",".staticTexts[\"Allan Munger\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/))
    }
    
    
    func testScrollingOnProfileImageSection() {
        let app = XCUIApplication()
        app.launchArguments.append("--UITest")
        app.launch()
        
        let profileImageCollectionView = app.collectionViews["profile image collection view"]
        
        // the asserts in the view controller will trigger
        // if anything goes wrong
        profileImageCollectionView/*@START_MENU_TOKEN@*/.swipeLeft()/*[[".swipeUp()",".swipeLeft()"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        profileImageCollectionView.swipeLeft()
        profileImageCollectionView.swipeLeft()
        profileImageCollectionView.swipeLeft()
        
        profileImageCollectionView.swipeRight()
        profileImageCollectionView.swipeRight()
        profileImageCollectionView.swipeRight()
        profileImageCollectionView.swipeRight()
        
        profileImageCollectionView.swipeLeft()
        profileImageCollectionView.swipeRight()
        profileImageCollectionView.swipeLeft()
        profileImageCollectionView.swipeRight()
    }
    
    func testPagingOnProfileInformationSection() {
        let app = XCUIApplication()
        app.launchArguments.append("--UITest")
        app.launch()
        
        let profileImageCollectionView = app.collectionViews["profile image collection view"]
        let profileInformationCollectionView = app.collectionViews["profile information collection view"]
        
        XCTAssertTrue(profileImageCollectionView.cells["profile image cell at 0"].isSelected)
        
        profileInformationCollectionView.swipeUp()
        XCTAssertTrue(profileImageCollectionView.cells["profile image cell at 1"].isSelected)
        
        profileInformationCollectionView.swipeUp()
        XCTAssertTrue(profileImageCollectionView.cells["profile image cell at 2"].isSelected)
        
        profileInformationCollectionView.swipeUp()
        XCTAssertTrue(profileImageCollectionView.cells["profile image cell at 3"].isSelected)
        
        profileInformationCollectionView.swipeUp()
        XCTAssertTrue(profileImageCollectionView.cells["profile image cell at 4"].isSelected)
        
        profileInformationCollectionView.swipeUp()
        XCTAssertTrue(profileImageCollectionView.cells["profile image cell at 5"].isSelected)
        
        profileInformationCollectionView.swipeDown()
        XCTAssertTrue(profileImageCollectionView.cells["profile image cell at 4"].isSelected)
        
        profileInformationCollectionView.swipeDown()
        XCTAssertTrue(profileImageCollectionView.cells["profile image cell at 3"].isSelected)
        
        profileInformationCollectionView.swipeDown()
        XCTAssertTrue(profileImageCollectionView.cells["profile image cell at 2"].isSelected)
        
        profileInformationCollectionView.swipeDown()
        XCTAssertTrue(profileImageCollectionView.cells["profile image cell at 1"].isSelected)
        
        profileInformationCollectionView.swipeDown()
        XCTAssertTrue(profileImageCollectionView.cells["profile image cell at 0"].isSelected)
    }
    
    func testCombination() {
        let app = XCUIApplication()
        app.launchArguments.append("--UITest")
        app.launch()
        
        let profileImageCollectionView = app.collectionViews["profile image collection view"]
        let profileInformationCollectionView = app.collectionViews["profile information collection view"]
        // the asserts in the view controller will trigger
        // if anything goes wrong
        profileImageCollectionView.cells["profile image cell at 1"].tap()
        let _ = waitForElementToAppear(profileInformationCollectionView.staticTexts["Amanda Brady"])
        profileImageCollectionView.cells["profile image cell at 2"].tap()
        let _ = waitForElementToAppear(profileInformationCollectionView/*@START_MENU_TOKEN@*/.staticTexts["Ashley Mc Carthy"]/*[[".cells[\"profile information cell at 2\"].staticTexts[\"Ashley Mc Carthy\"]",".staticTexts[\"Ashley Mc Carthy\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/)
        profileImageCollectionView.cells["profile image cell at 3"].tap()
        let _ = waitForElementToAppear(profileInformationCollectionView/*@START_MENU_TOKEN@*/.staticTexts["Carlos Slattery"]/*[[".cells[\"profile information cell at 3\"].staticTexts[\"Carlos Slattery\"]",".staticTexts[\"Carlos Slattery\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/)
        profileImageCollectionView.cells["profile image cell at 4"].tap()
        let _ = waitForElementToAppear(profileInformationCollectionView/*@START_MENU_TOKEN@*/.staticTexts["Carole Poland"]/*[[".cells[\"profile information cell at 4\"].staticTexts[\"Carole Poland\"]",".staticTexts[\"Carole Poland\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/)
        
        profileImageCollectionView.swipeLeft()
        profileImageCollectionView.swipeLeft()
        profileImageCollectionView.swipeRight()
        profileImageCollectionView.swipeRight()
        
        profileInformationCollectionView.swipeUp()
        profileInformationCollectionView.swipeUp()
        profileInformationCollectionView.swipeDown()
        profileInformationCollectionView.swipeDown()
    }
}
