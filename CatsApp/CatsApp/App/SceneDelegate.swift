//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import CatsFoundation
import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        let request = URLRequest(url: URL(string: "https://api.thecatapi.com/v1/breeds")!)

        let viewModel = BreedStore(
            loader: URLSession.shared
                .dataTaskPublisher(for: request)
                .tryMap { try BreedsMapper.map($0, from: $1 as! HTTPURLResponse) }
                .subscribe(on: DispatchQueue.global())
                .eraseToAnyPublisher()
        )

        let contentView = BreedsView(store: viewModel)

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
