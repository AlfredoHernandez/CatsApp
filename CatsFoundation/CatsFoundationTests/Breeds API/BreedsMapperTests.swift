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
        let breed0 = makeBreed(id: "an-id", name: "a name")
        let breed1 = makeBreed(id: "another-id", name: "another name")
        let json = makeItemsJSON([breed0.json, breed1.json])

        let breeds = try BreedsMapper.map(json, from: HTTPURLResponse(statusCode: 200))
        XCTAssertEqual(breeds, [breed0.model, breed1.model])
    }

    // MARK: Helpers

    func makeItemsJSON(_ json: [[String: Any]]) -> Data {
        try! JSONSerialization.data(withJSONObject: json)
    }

    private func makeBreed(id: String, name: String) -> (json: [String: Any], model: Breed) {
        let json = ["id": id, "name": name]
        let model = Breed(id: id, name: name)
        return (json, model)
    }
}

func anyURL() -> URL {
    URL(string: "http://any-url.com")!
}

extension HTTPURLResponse {
    convenience init(statusCode: Int) {
        self.init(url: anyURL(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
}
