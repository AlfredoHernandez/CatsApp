//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import CatsFoundation
import Combine
import SwiftUI

struct ContentView: View {
    @ObservedObject var store: BreedStore

    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(store.breeds) { breed in
                        Text(breed.name)
                    }
                }
                .navigationTitle(Text(store.title))
            }
            .onAppear(perform: store.fetchBreeds)
            SpinnerView(isAnimating: store.isLoading, style: .large)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            store: BreedStore(
                loader: CurrentValueSubject(
                    [
                        Breed(id: "abys", name: "Abyssinian"),
                        Breed(id: "aege", name: "Aegean"),
                    ]
                ).eraseToAnyPublisher()
            )
        )
    }
}
