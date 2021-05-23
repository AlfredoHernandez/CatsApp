//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Foundation

public struct PresentableBreed: Identifiable {
    public let id = UUID()
    public let name: String
    public let imageURL: URL?
    public let selectionHandler: () -> Void
    
    public init(name: String, imageURL: URL?, selectionHandler: @escaping () -> Void) {
        self.name = name
        self.imageURL = imageURL
        self.selectionHandler = selectionHandler
    }
    

    public var hasImageUrl: Bool {
        imageURL != nil
    }

    public func select() {
        selectionHandler()
    }
}
