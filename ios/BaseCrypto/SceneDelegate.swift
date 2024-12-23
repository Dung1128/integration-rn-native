//
//  SceneDelegate.swift
//  BaseCrypto
//
//  Created by Dũng Nguyễn on 23/12/24.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)

            // Đặt ContentView làm màn hình chính
            let contentView = ContentView()
            window.rootViewController = UIHostingController(rootView: contentView)

            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

