//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Foundation

public struct PresentableBreed: Identifiable, Equatable {
    public let id = UUID()
    public let breedID: String
    public let name: String
    public let description: String
    public let temperament: String
    public let origin: String
    public let lifeSpan: String
    public let imageURL: URL?

    internal init(breedID: String, name: String, description: String, temperament: String, origin: String, lifeSpan: String, imageURL: URL?) {
        self.breedID = breedID
        self.name = name
        self.description = description
        self.temperament = temperament
        self.origin = origin
        self.lifeSpan = lifeSpan
        self.imageURL = imageURL
    }

    public var hasImageUrl: Bool {
        imageURL != nil
    }
}
