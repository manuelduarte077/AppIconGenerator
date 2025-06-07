//
//  StatusMessageView.swift
//  DevIconGenerator
//
//  Created by Manuel Duarte on 6/7/25.
//

import SwiftUI

/// Tipo de mensaje de estado
enum StatusMessageType {
    case progress
    case success
    case error(Error)
    
    var icon: String {
        switch self {
        case .progress:
            return "arrow.clockwise"
        case .success:
            return "checkmark.circle"
        case .error:
            return "exclamationmark.triangle"
        }
    }
    
    var color: Color {
        switch self {
        case .progress:
            return .blue
        case .success:
            return .green
        case .error:
            return .red
        }
    }
    
    var message: String {
        switch self {
        case .progress:
            return "Generating icons..."
        case .success:
            return "Icons generated successfully!"
        case .error(let error):
            return error.localizedDescription
        }
    }
}

/// Vista reutilizable para mostrar mensajes de estado
struct StatusMessageView: View {
    let type: StatusMessageType
    let showProgress: Bool
    
    init(type: StatusMessageType, showProgress: Bool = false) {
        self.type = type
        self.showProgress = showProgress
    }
    
    var body: some View {
        VStack(spacing: 12) {
            if case .progress = type, showProgress {
                ProgressView()
                    .padding(.bottom, 4)
            } else {
                Image(systemName: type.icon)
                    .font(.system(size: 24))
                    .foregroundColor(type.color)
            }
            
            Text(type.message)
                .font(.subheadline)
                .foregroundColor(type.color)
                .multilineTextAlignment(.center)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(uiColor: .secondarySystemBackground))
        )
        .padding(.horizontal)
    }
}

struct StatusMessageView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            StatusMessageView(type: .progress, showProgress: true)
            StatusMessageView(type: .success)
            StatusMessageView(type: .error(NSError(domain: "com.example", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to generate icons"])))
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
