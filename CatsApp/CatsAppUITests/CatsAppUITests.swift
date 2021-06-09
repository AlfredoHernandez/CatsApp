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

        let image = app.images["breed.cat.image"].firstMatch
        XCTAssertTrue(image.exists)

        app.navigationBars.buttons["Breeds"].tap()
        XCTAssertEqual(app.cells.count, 67)
    }
}
