//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import CatsFoundation
import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        var request = URLRequest(url: URL(string: "https://api.thecatapi.com/v1/breeds")!)
        request.addValue("ed8f6c95-57c0-4343-be27-b49a6db7ef66", forHTTPHeaderField: "x-api-key")

        let viewModel = BreedStore(
            loader: URLSession.shared
                .dataTaskPublisher(for: request)
                .tryMap { $0 }
                .tryMap { try BreedsMapper.map($0, from: $1 as! HTTPURLResponse) }
                .subscribe(on: DispatchQueue.global())
                .eraseToAnyPublisher()
        )

        let contentView = ContentView(store: viewModel)

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
