//
//  IconPreviewView.swift
//  DevIconGenerator
//
//  Created by Manuel Duarte on 6/7/25.
//

import SwiftUI

/// Vista reutilizable para la previsualización de iconos
struct IconPreviewView: View {
    let image: UIImage?
    let onTap: () -> Void
    let isDisabled: Bool
    
    init(image: UIImage?, onTap: @escaping () -> Void, isDisabled: Bool = false) {
        self.image = image
        self.onTap = onTap
        self.isDisabled = isDisabled
    }
    
    var body: some View {
        Button {
            onTap()
        } label: {
            RoundedRectangle(cornerRadius: 24, style: .circular)
                .foregroundColor(.gray.opacity(0.5))
                .overlay {
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .cornerRadius(24)
                            .clipped()
                    } else {
                        VStack(spacing: 16) {
                            Image(systemName: "photo.on.rectangle.angled")
                                .font(.system(size: 40))
                            Text("Drag & Drop or Click to Select")
                                .font(.headline)
                            Text("Recommended size: 1024×1024")
                                .font(.caption)
                        }
                        .foregroundColor(.white)
                    }
                }
        }
        .buttonStyle(PlainButtonStyle())
        .contentShape(RoundedRectangle(cornerRadius: 24))
        .disabled(isDisabled)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

struct IconPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            IconPreviewView(image: nil, onTap: {})
                .frame(width: 200, height: 200)
            
            IconPreviewView(image: nil, onTap: {}, isDisabled: true)
                .frame(width: 200, height: 200)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
