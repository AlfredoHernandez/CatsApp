//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import CatsFoundation
import Combine
import Foundation

class BreedStore: ObservableObject {
    private var cancellable: Cancellable?
    private let loader: AnyPublisher<[Breed], Error>

    @Published var breeds: [PresentableBreed] = []
    @Published var isLoading: Bool = false
    var title: String { "Breeds" }

    init(loader: AnyPublisher<[Breed], Error>) {
        self.loader = loader
    }

    func fetchBreeds() {
        isLoading = true
        cancellable = loader
            .dispatchOnMainQueue()
            .sink(
                receiveCompletion: {
                    if case .failure = $0 { self.isLoading = false }
                },
                receiveValue: onReceive
            )
    }

    private func onReceive(breeds: [Breed]) {
        self.breeds = breeds.map { breed in
            PresentableBreed(
                name: breed.name,
                imageURL: breed.image
            )
        }
        isLoading = false
    }
}
