//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Foundation

public struct Breed: Equatable {
    public let id: String
    public let name: String
    public let origin: String
    public let description: String
    public let temperament: String
    public let lifeSpan: String
    public let adaptability: Int
    public let affectionLevel: Int
    public let childFriendly: Int
    public let dogFriendly: Int
    public let image: URL?
    public let weight: String

    public init(
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
        image: URL?,
        weight: String
    ) {
        self.id = id
        self.name = name
        self.origin = origin
        self.description = description
        self.temperament = temperament
        self.lifeSpan = lifeSpan
        self.adaptability = adaptability
        self.affectionLevel = affectionLevel
        self.childFriendly = childFriendly
        self.dogFriendly = dogFriendly
        self.image = image
        self.weight = weight
    }
}
