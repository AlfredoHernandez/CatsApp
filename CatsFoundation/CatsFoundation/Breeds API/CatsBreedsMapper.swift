//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Foundation

class CatsBreedsMapper {
    enum Error: Swift.Error {
        case invalidData
    }

    static func map(_ data: Data, from response: HTTPURLResponse) throws -> [Breed] {
        if !(200 ... 299).contains(response.statusCode) {
            throw Error.invalidData
        }
        return try data.decode(type: [Breed].self)
    }
}
