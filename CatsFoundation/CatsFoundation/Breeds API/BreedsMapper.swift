//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Foundation

public class BreedsMapper {
    private struct RemoteBreed: Decodable {
        let id: String
        let name: String
    }

    enum Error: Swift.Error {
        case invalidData
    }

    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> [Breed] {
        if !(200 ... 299).contains(response.statusCode) {
            throw Error.invalidData
        }
        return try data.decode(type: [RemoteBreed].self).map { Breed(id: $0.id, name: $0.name) }
    }
}
