//
//  BaseCryptoApp.swift
//  BaseCrypto
//
//  Created by Dũng Nguyễn on 8/11/24.
//

import SwiftUI
import React


@main
struct BaseCryptoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
//    var bridge: RCTBridge?
   
    
//    @StateObject private var vm = HomeViewModel()
    
    init(){
       
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
//            NavigationView{
//                HomeView()
//            }
//            .environmentObject(vm)
        }
    }
}
