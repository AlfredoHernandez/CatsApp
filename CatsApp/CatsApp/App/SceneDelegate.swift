//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import CatsFoundation
import Combine
import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    private lazy var scheduler: AnyDispatchQueueScheduler = DispatchQueue(
        label: "com.alfredohdz.cats-app.infra.queue",
        qos: .userInitiated,
        attributes: .concurrent
    ).eraseToAnyScheduler()

    convenience init(scheduler: AnyDispatchQueueScheduler) {
        self.init()
        self.scheduler = scheduler
    }

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            self.window = window
            configureWindow()
        }
    }

    func configureWindow() {
        window?.rootViewController = UIHostingController(
            rootView: BreedsUIComposer.composeWith(loader: breedsLoader())
        )
        window?.makeKeyAndVisible()
    }

    private func breedsLoader() -> AnyPublisher<[Breed], Error> {
        let request = URLRequest(url: URL(string: "https://api.thecatapi.com/v1/breeds")!)
        return URLSession.shared
            .httpDataTaskPublisher(for: request, mapper: BreedsMapper.map)
            .subscribe(on: scheduler)
            .eraseToAnyPublisher()
    }
}
