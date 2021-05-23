//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import CatsFoundation
import Combine
import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)

            window.rootViewController = UIHostingController(
                rootView: BreedsUIComposer.composeWith(loader: breedsLoader())
            )

            self.window = window
            window.makeKeyAndVisible()
        }
    }

    private func breedsLoader() -> AnyPublisher<[Breed], Error> {
        let request = URLRequest(url: URL(string: "https://api.thecatapi.com/v1/breeds")!)
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { try BreedsMapper.map($0, from: $1 as! HTTPURLResponse) }
            .subscribe(on: DispatchQueue.global())
            .eraseToAnyPublisher()
    }
}
