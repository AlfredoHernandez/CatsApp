//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

@testable import CatsFoundation
import XCTest

final class BreedsPresenterTests: XCTestCase {
    func test_hasTitle() {
        XCTAssertEqual(BreedsPresenter.title, "Breeds")
    }

    func test_map_createsPresentableBreed() {
        let breed = Breed(
            id: "any",
            name: "any",
            origin: "mx",
            description: "a description",
            temperament: "a temperament",
            lifeSpan: "1 - 2",
            adaptability: 1,
            affectionLevel: 2,
            childFriendly: 3,
            dogFriendly: 4,
            image: nil,
            weight: "3 - 5"
        )

        let presentableBreed = BreedsPresenter.map(breed)

        XCTAssertEqual(presentableBreed.breedID, "id: \(breed.id)")
        XCTAssertEqual(presentableBreed.name, breed.name)
        XCTAssertEqual(presentableBreed.description, breed.description)
        XCTAssertEqual(presentableBreed.temperament, breed.temperament)
        XCTAssertEqual(presentableBreed.origin, breed.origin)
        XCTAssertEqual(presentableBreed.lifeSpan, "\(breed.lifeSpan) average life span")
    }
}
