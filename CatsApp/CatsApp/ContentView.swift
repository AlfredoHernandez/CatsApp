//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Combine
import SwiftUI

class CatsBreedViewModel: ObservableObject {
    @Published var breeds: [Breed] = []
    var cancellable: Cancellable?

    func doRequest() {
        let url = URL(string: "https://api.thecatapi.com/v1/breeds")!
        cancellable = URLSession.shared
            .dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global())
            .tryMap(mapBreeds)
            .decode(type: [Breed].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { [weak self] response in
                self?.breeds = response
            })
    }

    private func mapBreeds(data: Data, response _: URLResponse) throws -> Data {
        data
    }
}

struct ContentView: View {
    @ObservedObject var viewModel = CatsBreedViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.breeds, id: \.id) { breed in
                    Text(breed.name)
                }
            }
            .navigationTitle(Text("Cats Breeds"))
        }
        .onAppear(perform: viewModel.doRequest)
    }
}

struct Breed: Decodable {
    let id: String
    let name: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
