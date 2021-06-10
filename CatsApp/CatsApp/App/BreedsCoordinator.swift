//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import CatsFoundation
import Combine
import Foundation
import SwiftUI

class BreedsCoordinator {
    private let scheduler: AnyDispatchQueueScheduler

    init(scheduler: AnyDispatchQueueScheduler) {
        self.scheduler = scheduler
    }

    private func breedsLoader() -> AnyPublisher<[Breed], Error> {
        let request = URLRequest(url: URL(string: "https://api.thecatapi.com/v1/breeds")!)
        return URLSession.shared
            .httpDataTaskPublisher(for: request, mapper: BreedsMapper.map)
            .subscribe(on: scheduler)
            .eraseToAnyPublisher()
    }

    private func makeAlwaysFailingLoader() -> AnyPublisher<[Breed], Error> {
        Fail(error: NSError(domain: "Failable loader for testing", code: 0, userInfo: [:]))
            .eraseToAnyPublisher()
    }

    private func makeTestingLoader() -> AnyPublisher<[Breed], Error> {
        CurrentValueSubject(
            [
                Breed(
                    id: "abys",
                    name: "Abyssinian",
                    origin: "Egypt",
                    description: "The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals.",
                    temperament: "Active, Energetic, Independent, Intelligent, Gentle",
                    lifeSpan: "14 - 15",
                    adaptability: 3,
                    affectionLevel: 5,
                    childFriendly: 4,
                    dogFriendly: 3,
                    image: nil,
                    weight: "12 - 15"
                ),
                Breed(
                    id: "abys",
                    name: "Abyssinian",
                    origin: "Egypt",
                    description: "The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals.",
                    temperament: "Active, Energetic, Independent, Intelligent, Gentle",
                    lifeSpan: "14 - 15",
                    adaptability: 3,
                    affectionLevel: 5,
                    childFriendly: 4,
                    dogFriendly: 3,
                    image: nil,
                    weight: "12 - 15"
                ),
            ]
        ).eraseToAnyPublisher()
    }

    func start() -> UIViewController {
        UIHostingController(
            rootView: BreedsUIComposer.composeWith(loader: selectLoader())
        )
    }

    private func selectLoader() -> AnyPublisher<[Breed], Error> {
        #if DEBUG
        if UserDefaults.standard.string(forKey: "connectivity") == "testing" {
            return makeTestingLoader()
        } else if UserDefaults.standard.string(forKey: "connectivity") == "offline" {
            return makeAlwaysFailingLoader()
        }
        #endif
        return breedsLoader()
    }
}
