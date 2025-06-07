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
                        // Aumentar el tamaño mínimo para aprovechar mejor el espacio en desktop
                        sizeRestrictions.minimumSize = CGSize(width: 800, height: 600)
                        // Permitir redimensionar la ventana para una mejor experiencia de usuario
                        sizeRestrictions.maximumSize = CGSize(width: 1200, height: 800)
                    }
                    
                    // Configurar la apariencia para modo desktop
                    configureDesktopAppearance()
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
    
    // Función para configurar la apariencia en modo desktop
    private func configureDesktopAppearance() {
        #if targetEnvironment(macCatalyst)
        // Personalizar la apariencia de los controles para que se vean más nativos en macOS
        UISegmentedControl.appearance().selectedSegmentTintColor = .systemBlue
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        
        // Personalizar la apariencia de los botones
        let buttonAppearance = UIButton.appearance()
        buttonAppearance.tintColor = .systemBlue
        
        // Personalizar la apariencia de los toggles
        UISwitch.appearance().onTintColor = .systemBlue
        #endif
    }
}
