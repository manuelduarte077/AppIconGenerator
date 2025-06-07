//
//  Extensions.swift
//  DevIconGenerator
//
//  Created by Manuel Duarte on 6/7/25.
//

import Foundation
import SwiftUI

// MARK: - CGFloat Extensions
extension CGFloat {
    
    var formattedString: String {
        truncatingRemainder(dividingBy: 1) == 0 ? String(Int(self)) : String(format: "%.1f", self)
    }
}

// MARK: - View Extensions
extension View {
    /// Aplica un estilo de sombra consistente en toda la aplicación
    func standardShadow() -> some View {
        self.shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
    
    /// Aplica un estilo de borde redondeado consistente
    func standardRoundedBorder() -> some View {
        self.overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
        .cornerRadius(12)
    }
}

// MARK: - Color Extensions
extension Color {
    static let appBackground = Color(uiColor: .systemBackground)
    static let appSecondaryBackground = Color(uiColor: .secondarySystemBackground)
    static let appAccent = Color.blue
}
