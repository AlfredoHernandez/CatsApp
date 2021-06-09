//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

@testable import CatsApp
import SwiftUI
import XCTest

final class CatsAcceptanceTests: XCTestCase {
    func test_launchApp() {
        let app = launch()

        XCTAssertNotNil(app, "Expected to run application")
    }

    // MARK: - Helpers

    private func launch() -> UIHostingController<BreedsView> {
        let scene = SceneDelegate(scheduler: .immediateOnMainQueue)
        let window = UIWindow()
        scene.window = window
        scene.configureWindow()
        return scene.window?.rootViewController as! UIHostingController<BreedsView>
    }
}
