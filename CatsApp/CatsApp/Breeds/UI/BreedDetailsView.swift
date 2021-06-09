//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import CatsFoundation
import Kingfisher
import SwiftUI

struct BreedDetailsView: View {
    let breed: PresentableBreed
    @State var isLoaded = false

    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                if let imageUrl = breed.imageURL {
                    KFImage.url(imageUrl)
                        .fade(duration: 0.25)
                        .resizable()
                        .scaledToFill()
                        .clipShape(RoundedRectangle(cornerRadius: 8.0))
                        .shadow(radius: 4)
                        .padding()
                        .accessibility(identifier: "breed.cat.image")
                } else {
                    Image("default-cat")
                        .resizable()
                        .scaledToFill()
                        .clipShape(RoundedRectangle(cornerRadius: 8.0))
                        .shadow(radius: 4)
                        .padding()
                        .accessibility(identifier: "breed.cat.image")
                }
                Text(breed.name)
                    .font(.largeTitle)
                Text(breed.breedID)
                    .font(.body.bold())
                Text(breed.description)
                Text(breed.temperament)
                    .font(.body.italic())
                Text(breed.origin)
                Text(breed.lifeSpan)
                Spacer()
                Spacer()
            }
            .padding()
        }
        .navigationBarTitle(Text(breed.name), displayMode: .inline)
    }
}

struct BreedDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                BreedDetailsView(
                    breed: PresentableBreed(
                        breedID: "id: beng",
                        name: "Bengal",
                        description: "Bengals are a lot of fun to live with, but they're definitely not the cat for everyone, or for first-time cat owners. Extremely intelligent, curious and active, they demand a lot of interaction and woe betide the owner who doesn't provide it.",
                        temperament: "Alert, Agile, Energetic, Demanding, Intelligent",
                        origin: "United States",
                        lifeSpan: "12 - 15 average life span",
                        imageURL: URL(string: "https://cdn2.thecatapi.com/images/Rl39SPjDO.png")!
                    )
                )
            }
            NavigationView {
                BreedDetailsView(
                    breed: PresentableBreed(
                        breedID: "id: beng",
                        name: "Bengal",
                        description: "Bengals are a lot of fun to live with, but they're definitely not the cat for everyone, or for first-time cat owners. Extremely intelligent, curious and active, they demand a lot of interaction and woe betide the owner who doesn't provide it.",
                        temperament: "Alert, Agile, Energetic, Demanding, Intelligent",
                        origin: "United States",
                        lifeSpan: "12 - 15 average life span",
                        imageURL: nil
                    )
                )
            }.environment(\.colorScheme, .dark)
        }
    }
}
