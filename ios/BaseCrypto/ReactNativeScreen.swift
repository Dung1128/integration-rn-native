//
//  ReactNativeScreen.swift
//  BaseCrypto
//
//  Created by Dũng Nguyễn on 19/12/24.
//

import SwiftUI

struct ReactNativeScreen: UIViewControllerRepresentable {
    let moduleName: String
    let initialProps: [String: Any]?

    func makeUIViewController(context: Context) -> ReactNativeViewController {
        return ReactNativeViewController(moduleName: moduleName, initialProps: initialProps)
    }

    func updateUIViewController(_ uiViewController: ReactNativeViewController, context: Context) {
        // Không cần cập nhật controller
    }
}

