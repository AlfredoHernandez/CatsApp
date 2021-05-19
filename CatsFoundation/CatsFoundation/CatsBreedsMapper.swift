//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Foundation

class CatsBreedsMapper {
    enum Error: Swift.Error {
        case invalidData
    }

    static func map(_: Data, from response: HTTPURLResponse) throws {
        if !(200 ... 299).contains(response.statusCode) {
            throw Error.invalidData
        }
    }
}
