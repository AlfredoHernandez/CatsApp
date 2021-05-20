//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Foundation

struct Breed: Decodable {
    let id: String
    let name: String
}

class CatsBreedsMapper {
    enum Error: Swift.Error {
        case invalidData
    }

    static func map(_ data: Data, from response: HTTPURLResponse) throws {
        if !(200 ... 299).contains(response.statusCode) {
            throw Error.invalidData
        }
        _ = try data.decode(type: [Breed].self)
    }
}

public extension Data {
    func decode<Item>(type _: Item.Type) throws -> Item where Item: Decodable {
        try JSONDecoder().decode(Item.self, from: self)
    }
}
