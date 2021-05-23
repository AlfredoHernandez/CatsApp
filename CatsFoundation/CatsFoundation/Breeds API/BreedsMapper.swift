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
    }

    private struct RemoteImage: Decodable {
        let url: URL?
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
            .map {
                Breed(
                    id: $0.id,
                    name: $0.name,
                    origin: $0.origin,
                    description: $0.description,
                    temperament: $0.temperament,
                    lifeSpan: $0.life_span,
                    adaptability: $0.adaptability,
                    affectionLevel: $0.affection_level,
                    childFriendly: $0.child_friendly,
                    dogFriendly: $0.dog_friendly,
                    image: $0.image?.url
                )
            }
    }
}
