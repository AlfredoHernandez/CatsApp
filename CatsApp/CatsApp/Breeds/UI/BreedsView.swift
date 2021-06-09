//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import CatsFoundation
import Combine
import SwiftUI

struct BreedsView: View {
    @ObservedObject var store: BreedStore
    let onSelect: (PresentableBreed) -> AnyView

    var body: some View {
        ZStack {
            NavigationView {
                List(store.breeds) { breed in
                    NavigationLink(destination: onSelect(breed), label: {
                        BreedCellView(breed: breed)
                    })
                }
                .listStyle(PlainListStyle())
                .navigationTitle(Text(store.title))
            }
            .onAppear(perform: store.fetchBreeds)
            SpinnerView(isAnimating: store.isLoading, style: .large)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BreedsView(
            store: BreedStore(
                loader: CurrentValueSubject(
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
            ), onSelect: { _ in
                AnyView(EmptyView())
            }
        )
    }
}
