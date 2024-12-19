//
//  ReactNativeViewController.swift
//  BaseCrypto
//
//  Created by Dũng Nguyễn on 19/12/24.
//

import UIKit
import React

class ReactNativeViewController: UIViewController {
    var moduleName: String
    var initialProps: [String: Any]?

    init(moduleName: String, initialProps: [String: Any]? = nil) {
        self.moduleName = moduleName
        self.initialProps = initialProps
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let jsCodeLocation = RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index", fallbackExtension: nil)

        let bridge = RCTBridge(bundleURL: jsCodeLocation, moduleProvider: nil, launchOptions: nil)
        let rootView = RCTRootView(bridge: bridge!, moduleName: moduleName, initialProperties: initialProps)
        rootView.frame = self.view.bounds
        rootView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(rootView)
    }
}

