//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import CatsFoundation
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
        window?.rootViewController = BreedsCoordinator(scheduler: scheduler).start()
        window?.makeKeyAndVisible()
    }
}
