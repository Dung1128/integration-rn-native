//
//  ReactNativeView.swift
//  BaseCrypto
//
//  Created by Dũng Nguyễn on 19/12/24.
//

import SwiftUI
import React

struct ReactNativeView: UIViewControllerRepresentable {
    let moduleName: String
    let initialProps: [String: Any]?

    func makeUIViewController(context: Context) -> UIViewController {
        let jsCodeLocation: URL

        #if DEBUG
        jsCodeLocation = RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index", fallbackExtension: nil)!
        #else
        jsCodeLocation = Bundle.main.url(forResource: "main", withExtension: "jsbundle")!
        #endif

        let bridge = RCTBridge(bundleURL: jsCodeLocation, moduleProvider: nil, launchOptions: nil)
        let rootView = RCTRootView(bridge: bridge!, moduleName: moduleName, initialProperties: initialProps)
        
        let viewController = UIViewController()
        rootView.frame = viewController.view.bounds
        rootView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.view.addSubview(rootView)
        
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Không cần cập nhật
    }
}

