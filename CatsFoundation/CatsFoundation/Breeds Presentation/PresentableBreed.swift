//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Foundation

public struct PresentableBreed: Identifiable {
    public let id = UUID()
    public let name: String
    public let imageURL: URL?

    public init(name: String, imageURL: URL?) {
        self.name = name
        self.imageURL = imageURL
    }

    public var hasImageUrl: Bool {
        imageURL != nil
    }
}
