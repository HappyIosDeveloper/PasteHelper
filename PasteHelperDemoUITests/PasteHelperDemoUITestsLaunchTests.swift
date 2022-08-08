//
//  PasteHelperDemoUITestsLaunchTests.swift
//  PasteHelperDemoUITests
//
//  Created by Ahmadreza on 8/5/22.
//

import XCTest

class PasteHelperDemoUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
        
        let pasteYourTextTextField = app.textFields["paste your text"]
        pasteYourTextTextField.tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
    }
}
