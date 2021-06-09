//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

@testable import CatsFoundation
import XCTest

struct BreedsPresenter {
    let title = "Breeds"

    func map(_ breed: Breed) -> PresentableBreed {
        PresentableBreed(
            breedID: "id: \(breed.id)",
            name: breed.name,
            description: breed.description,
            temperament: breed.temperament,
            origin: breed.origin,
            lifeSpan: "\(breed.lifeSpan) average life span",
            imageURL: breed.image
        )
    }
}

final class BreedsPresenterTests: XCTestCase {
    func test_hasTitle() {
        let sut = BreedsPresenter()

        XCTAssertEqual(sut.title, "Breeds")
    }

    func test_map_createsPresentableBreed() {
        let sut = BreedsPresenter()
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

        let presentableBreed = sut.map(breed)

        XCTAssertEqual(presentableBreed.breedID, "id: \(breed.id)")
        XCTAssertEqual(presentableBreed.name, breed.name)
        XCTAssertEqual(presentableBreed.description, breed.description)
        XCTAssertEqual(presentableBreed.temperament, breed.temperament)
        XCTAssertEqual(presentableBreed.origin, breed.origin)
        XCTAssertEqual(presentableBreed.lifeSpan, "\(breed.lifeSpan) average life span")
    }
}
