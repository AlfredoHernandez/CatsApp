//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

@testable import CatsFoundation
import XCTest

class CatsBreedsMapperTests: XCTestCase {
    func test_map_throwsErrorOnNon200HTTPResponse() throws {
        let json = makeItemsJSON([])
        let samples = [199, 300, 400, 500]

        try samples.forEach { code in
            XCTAssertThrowsError(
                try CatsBreedsMapper.map(json, from: HTTPURLResponse(statusCode: code))
            )
        }
    }

    func test_map_throwsErrorOn200HTTPResponseWithInvalidJSON() {
        let json = Data("invalid json".utf8)

        XCTAssertThrowsError(
            try CatsBreedsMapper.map(json, from: HTTPURLResponse(statusCode: 200))
        )
    }

    func test_map_deliversNoItemsOn200HTTPResponseWithEmptyJSONList() throws {
        let json = makeItemsJSON([])

        let breeds = try CatsBreedsMapper.map(json, from: HTTPURLResponse(statusCode: 200))
        XCTAssertEqual(breeds, [])
    }

    // MARK: Helpers

    func makeItemsJSON(_ json: [[String: Any]]) -> Data {
        try! JSONSerialization.data(withJSONObject: json)
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
