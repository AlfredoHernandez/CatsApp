//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import CatsFoundation
import XCTest

class BreedsMapperTests: XCTestCase {
    func test_map_throwsErrorOnNon200HTTPResponse() throws {
        let json = makeItemsJSON([])
        let samples = [199, 300, 400, 500]

        try samples.forEach { code in
            XCTAssertThrowsError(
                try BreedsMapper.map(json, from: HTTPURLResponse(statusCode: code))
            )
        }
    }

    func test_map_throwsErrorOn200HTTPResponseWithInvalidJSON() {
        let json = Data("invalid json".utf8)

        XCTAssertThrowsError(
            try BreedsMapper.map(json, from: HTTPURLResponse(statusCode: 200))
        )
    }

    func test_map_deliversNoItemsOn200HTTPResponseWithEmptyJSONList() throws {
        let json = makeItemsJSON([])

        let breeds = try BreedsMapper.map(json, from: HTTPURLResponse(statusCode: 200))
        XCTAssertEqual(breeds, [])
    }

    func test_map_deliversItemsOn200HTTPResponseWithJSONItems() throws {
        let breed0 = makeBreed(
            id: "an-id",
            name: "a name",
            origin: "origin0",
            description: "description0",
            temperament: "temperament0",
            lifeSpan: "lifeSpan0",
            adaptability: 5,
            affectionLevel: 4,
            childFriendly: 4,
            dogFriendly: 2,
            image: anyURL()
        )
        let breed1 = makeBreed(
            id: "another-id",
            name: "another name",
            origin: "origin1",
            description: "description1",
            temperament: "temperament1",
            lifeSpan: "lifeSpan1",
            adaptability: 1,
            affectionLevel: 2,
            childFriendly: 3,
            dogFriendly: 4,
            image: nil
        )
        let json = makeItemsJSON([breed0.json, breed1.json])

        let breeds = try BreedsMapper.map(json, from: HTTPURLResponse(statusCode: 200))
        XCTAssertEqual(breeds, [breed0.model, breed1.model])
    }

    // MARK: Helpers

    func makeItemsJSON(_ json: [[String: Any]]) -> Data {
        try! JSONSerialization.data(withJSONObject: json)
    }

    private func makeBreed(
        id: String,
        name: String,
        origin: String,
        description: String,
        temperament: String,
        lifeSpan: String,
        adaptability: Int,
        affectionLevel: Int,
        childFriendly: Int,
        dogFriendly: Int,
        image: URL?
    ) -> (json: [String: Any], model: Breed) {
        let json: [String: Any] = [
            "id": id,
            "name": name,
            "origin": origin,
            "description": description,
            "temperament": temperament,
            "life_span": lifeSpan,
            "adaptability": adaptability,
            "affection_level": affectionLevel,
            "child_friendly": childFriendly,
            "dog_friendly": dogFriendly,
            "image": ["url": image?.absoluteString],
        ]
        let model = Breed(
            id: id,
            name: name,
            origin: origin,
            description: description,
            temperament: temperament,
            lifeSpan: lifeSpan,
            adaptability: adaptability,
            affectionLevel: affectionLevel,
            childFriendly: childFriendly,
            dogFriendly: dogFriendly,
            image: image
        )
        return (json, model)
    }
}
