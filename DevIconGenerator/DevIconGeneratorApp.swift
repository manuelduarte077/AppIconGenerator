//
//  DevIconGeneratorApp.swift
//  DevIconGenerator
//
//  Created by Manuel Duarte on 6/6/25.
//

import SwiftUI

@main
struct DevIconGeneratorApp: App {
    var body: some Scene {
        WindowGroup {
            #if targetEnvironment(macCatalyst)
            ContentView()
                .onAppear {
                    configureWindowForDesktop()
                    configureDesktopAppearance()
                }
            #else
            NavigationView {
                ContentView()
                    .navigationTitle(Constants.App.shortName)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            #endif
        }
    }

    // MARK: - Configuración de la ventana para modo desktop
    private func configureWindowForDesktop() {
        #if targetEnvironment(macCatalyst)
        guard let scenes = UIApplication.shared.connectedScenes as? Set<UIWindowScene> else { return }
        for window in scenes {
            window.title = Constants.App.name
            guard let sizeRestrictions = window.sizeRestrictions else { continue }
            sizeRestrictions.minimumSize = CGSize(
                width: Constants.UI.Window.minWidth,
                height: Constants.UI.Window.minHeight
            )
            // Sin máximo para permitir redimensionar la ventana libremente
            sizeRestrictions.maximumSize = CGSize(width: 4096, height: 4096)
        }
        #endif
    }
    
    // MARK: - Configuración de la apariencia en modo desktop
    private func configureDesktopAppearance() {
        #if targetEnvironment(macCatalyst)
        UISegmentedControl.appearance().selectedSegmentTintColor = .systemBlue
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        
        let buttonAppearance = UIButton.appearance()
        buttonAppearance.tintColor = .systemBlue
        
        UISwitch.appearance().onTintColor = .systemBlue
        #endif
    }
}
