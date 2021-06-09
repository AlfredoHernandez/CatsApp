//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import XCTest

class CatsAppUITests: XCTestCase {
    func test_launchApp_navigatesToDetails() {
        let app = XCUIApplication()
        app.launch()

        let cell = app.cells.firstMatch
        cell.tap()

        XCTAssertTrue(app.title.isEmpty, "Expected view with no title")
    }
}
