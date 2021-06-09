//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

@testable import CatsFoundation
import XCTest

struct BreedsPresenter {
    let title = "Breeds"
}

final class BreedsPresenterTests: XCTestCase {
    func test_hasTitle() {
        let sut = BreedsPresenter()

        XCTAssertEqual(sut.title, "Breeds")
    }
}
