//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Foundation

struct PresentableBreed: Identifiable {
    let id = UUID()
    let name: String
    let imageURL: URL?
    let selectionHandler: () -> Void

    var hasImageUrl: Bool {
        imageURL != nil
    }

    func select() {
        selectionHandler()
    }
}
