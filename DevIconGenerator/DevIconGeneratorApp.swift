//
//  DevIconGeneratorApp.swift
//  DevIconGenerator
//
//  Created by Manuel Duarte on 6/6/25.
//

import SwiftUI

@main
struct XCAIconGeneratorApp: App {
    var body: some Scene {
        WindowGroup {
            #if targetEnvironment(macCatalyst)
            ContentView()
                .onAppear {
                    guard let scenes = UIApplication.shared.connectedScenes as? Set<UIWindowScene> else { return }
                    for window in scenes {
                        window.title = "DEV Icon Generator"
                        guard let sizeRestrictions = window.sizeRestrictions else { continue }
                        sizeRestrictions.minimumSize = CGSize(width: 360, height: 600)
                        sizeRestrictions.maximumSize = sizeRestrictions.minimumSize
                    }
                }
            #else
            NavigationView {
                ContentView()
                    .navigationTitle("DEV Icon Gen")
            }
            .navigationViewStyle(StackNavigationViewStyle())
            #endif
        }
    }
}
