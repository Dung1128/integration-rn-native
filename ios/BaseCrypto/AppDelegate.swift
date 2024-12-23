//
//  AppDelegate.swift
//  BaseCrypto
//
//  Created by Dũng Nguyễn on 23/12/24.
//

import UIKit
import React

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var bridge: RCTBridge?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Khởi tạo React Native bridge
        let jsCodeLocation = RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index", fallbackExtension: nil)
        self.bridge = RCTBridge(bundleURL: jsCodeLocation, moduleProvider: nil, launchOptions: launchOptions)

        return true
    }
}

