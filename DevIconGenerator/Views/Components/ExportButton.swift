//
//  ExportButton.swift
//  DevIconGenerator
//
//  Created by Manuel Duarte on 6/7/25.
//

import SwiftUI

/// Botón de exportación reutilizable
struct ExportButton: View {
    let action: () -> Void
    let isDisabled: Bool
    let fullWidth: Bool
    
    init(action: @escaping () -> Void, isDisabled: Bool = false, fullWidth: Bool = false) {
        self.action = action
        self.isDisabled = isDisabled
        self.fullWidth = fullWidth
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Label("Export Icons", systemImage: "square.and.arrow.up")
                .frame(maxWidth: fullWidth ? .infinity : nil)
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .disabled(isDisabled)
    }
}

struct ExportButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            ExportButton(action: {}, isDisabled: false)
            ExportButton(action: {}, isDisabled: true)
            ExportButton(action: {}, isDisabled: false, fullWidth: true)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
