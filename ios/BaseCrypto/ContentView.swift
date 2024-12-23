//
//  ContentView.swift
//  BaseCrypto
//
//  Created by Dũng Nguyễn on 8/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
                    VStack {
                        Text("SwiftUI Home Screen")
                            .font(.title)

                        NavigationLink(
                            destination: ReactNativeScreen(
                                moduleName: "BaseCryptoRN",
                                initialProps: ["message": "Hello from SwiftUI"]
                            )
                        ) {
                            Text("Go to React Native Screen")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        NavigationLink(
                            destination: ReactNativeScreen(
                                moduleName: "Home",
                                initialProps: ["message": "Hello from SwiftUI to SecondScreen"]
                            )
                        ) {
                            Text("Go to Home React Native Screen")
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding()
                    }
                    .navigationTitle("SwiftUI to React Native")
                }
    }
}

#Preview {
    ContentView()
}
