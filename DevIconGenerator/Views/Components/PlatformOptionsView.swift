//
//  PlatformOptionsView.swift
//  DevIconGenerator
//
//  Created by Manuel Duarte on 6/7/25.
//

import SwiftUI

/// Vista reutilizable para las opciones de plataforma
struct PlatformOptionsView: View {
    @Binding var isExportingToiPhone: Bool
    @Binding var isExportingToiPad: Bool
    @Binding var isExportingToMac: Bool
    @Binding var isExportingToWatch: Bool
    let isDisabled: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Toggle("iPhone", isOn: $isExportingToiPhone)
            Toggle("iPad", isOn: $isExportingToiPad)
            Toggle("Mac", isOn: $isExportingToMac)
            Toggle("Apple Watch", isOn: $isExportingToWatch)
        }
        .disabled(isDisabled)
    }
}

struct PlatformOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        PlatformOptionsView(
            isExportingToiPhone: .constant(true),
            isExportingToiPad: .constant(true),
            isExportingToMac: .constant(false),
            isExportingToWatch: .constant(false),
            isDisabled: false
        )
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
