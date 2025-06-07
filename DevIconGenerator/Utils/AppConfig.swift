//
//  AppConfig.swift
//  DevIconGenerator
//
//  Created by Manuel Duarte on 6/7/25.
//

import Foundation
import SwiftUI

/// Clase de configuración centralizada para la aplicación
struct AppConfig {
    // MARK: - Constantes de la aplicación
    struct Constants {
        static let appName = "DEV Icon Generator"
        static let appShortName = "DEV Icon Gen"
        static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        static let appBuild = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
        
        // Tamaños de ventana para macOS
        static let minWindowWidth: CGFloat = 800
        static let minWindowHeight: CGFloat = 600
        static let maxWindowWidth: CGFloat = 1200
        static let maxWindowHeight: CGFloat = 800
        
        // Tamaños de iconos
        static let previewIconSize: CGFloat = 300
        static let mobileIconSize: CGFloat = 200
        static let sidebarWidth: CGFloat = 250
        
        // Recomendaciones
        static let recommendedIconSize = "1024×1024"
    }
    
    // MARK: - Configuración de UI
    struct UI {
        static let cornerRadius: CGFloat = 24
        static let standardPadding: CGFloat = 20
        static let standardSpacing: CGFloat = 16
        
        static let primaryColor = Color.blue
        static let secondaryColor = Color.gray.opacity(0.5)
        static let successColor = Color.green
        static let errorColor = Color.red
    }
}
