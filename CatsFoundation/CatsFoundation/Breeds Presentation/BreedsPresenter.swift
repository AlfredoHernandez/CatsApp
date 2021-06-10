//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Foundation

public struct BreedsPresenter {
    public static let title = "Breeds"

    public static func map(_ breed: Breed) -> PresentableBreed {
        PresentableBreed(
            breedID: "id: \(breed.id)",
            name: breed.name,
            description: breed.description,
            temperament: breed.temperament,
            origin: breed.origin,
            lifeSpan: "\(breed.lifeSpan) average life span",
            imageURL: breed.image
        )
    }
}
