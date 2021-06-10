//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import CatsFoundation
import Combine
import Foundation
import SwiftUI

class BreedsUIComposer {
    static func composeWith(loader: AnyPublisher<[Breed], Error>) -> BreedsView {
        let store = BreedStore(loader: loader)
        return BreedsView(store: store, onSelect: { breed in
            AnyView(BreedDetailsView(breed: breed))
        })
    }
}
