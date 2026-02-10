//
//  Constants.swift
//  DevIconGenerator
//
//  Created by Manuel Duarte on 6/7/25.
//

import Foundation
import SwiftUI

/// Constantes globales para la aplicación
enum Constants {
    // MARK: - Información de la aplicación
    enum App {
        static let name = "DEV Icon Generator"
        static let shortName = "DEV Icon Gen"
        static let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        static let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
    }
    
    // MARK: - UI
    enum UI {
        static let cornerRadius: CGFloat = 24
        static let standardPadding: CGFloat = 20
        static let standardSpacing: CGFloat = 16
        
        static let primaryColor = Color.blue
        static let secondaryColor = Color.gray.opacity(0.5)
        static let successColor = Color.green
        static let errorColor = Color.red
        
        enum Window {
            static let minWidth: CGFloat = 800
            static let minHeight: CGFloat = 600
            static let maxWidth: CGFloat = 1200
            static let maxHeight: CGFloat = 800
        }
        
        enum IconSize {
            static let preview: CGFloat = 300
            static let mobile: CGFloat = 200
            static let sidebarWidth: CGFloat = 250
            static let recommended = "1024×1024"
        }

        enum SizePreview {
            static let labels = ["29 pt", "60 pt", "1024 pt"]
            static let displaySizes: [CGFloat] = [29, 60, 120]
        }
    }
    
    // MARK: - Mensajes
    enum Messages {
        static let successExport = "Icons generated successfully!"
        static let dragDropHint = "Drag & Drop or Click to Select"
        static let sizeRecommendation = "Recommended size: 1024×1024"
        static let generatingIcons = "Generating icons..."
    }
}
