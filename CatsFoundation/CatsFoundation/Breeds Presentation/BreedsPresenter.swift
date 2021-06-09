//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Foundation

struct BreedsPresenter {
    let title = "Breeds"

    func map(_ breed: Breed) -> PresentableBreed {
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
