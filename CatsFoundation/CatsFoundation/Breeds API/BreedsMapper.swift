//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Foundation

public class BreedsMapper {
    private struct RemoteBreed: Decodable {
        let id: String
        let name: String
        let origin: String
        let description: String
        let temperament: String
        let life_span: String
        let adaptability: Int
        let affection_level: Int
        let child_friendly: Int
        let dog_friendly: Int
        let image: RemoteImage?
        let weight: RemoteWeight

        func toModel() -> Breed {
            Breed(
                id: id,
                name: name,
                origin: origin,
                description: description,
                temperament: temperament,
                lifeSpan: life_span,
                adaptability: adaptability,
                affectionLevel: affection_level,
                childFriendly: child_friendly,
                dogFriendly: dog_friendly,
                image: image?.url,
                weight: weight.metric
            )
        }
    }

    private struct RemoteImage: Decodable {
        let url: URL?
    }

    private struct RemoteWeight: Decodable {
        let metric: String
        let imperial: String
    }

    enum Error: Swift.Error {
        case invalidData
    }

    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> [Breed] {
        if !(200 ... 299).contains(response.statusCode) {
            throw Error.invalidData
        }
        return try data
            .decode(type: [RemoteBreed].self)
            .map { $0.toModel() }
    }
}
