//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import CatsFoundation
import Kingfisher
import SwiftUI

struct BreedCellView: View {
    let breed: PresentableBreed

    var body: some View {
        HStack(alignment: .center) {
            if let imageUrl = breed.imageURL {
                KFImage.url(imageUrl)
                    .fade(duration: 0.25)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 64, height: 64, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 8.0))
                    .shadow(radius: 4)
            } else {
                Image("default-cat")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 64, height: 64, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 8.0))
                    .shadow(radius: 4)
            }
            Text(breed.name)
        }
    }
}

struct BreedCellView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BreedCellView(breed: PresentableBreed(
                breedID: "aby",
                name: "Abyssinian",
                description: "any",
                temperament: "any",
                origin: "any",
                lifeSpan: "any",
                imageURL: nil
            ))
                .previewLayout(.fixed(width: 350, height: 80))
            BreedCellView(breed: PresentableBreed(
                breedID: "aby",
                name: "Abyssinian",
                description: "any",
                temperament: "any",
                origin: "any",
                lifeSpan: "any",
                imageURL: URL(string: "https://i.pinimg.com/originals/4d/9b/06/4d9b06aa653b75d719e35086b9aa885c.jpg")
            ))
                .preferredColorScheme(.dark)
                .previewLayout(.fixed(width: 350, height: 80))
        }
    }
}
