//
//  IconSizePreviewView.swift
//  DevIconGenerator
//
//  Created by Manuel Duarte on 6/6/25.
//

import SwiftUI

struct IconSizePreviewView: View {
    let image: UIImage

    var body: some View {
        VStack(alignment: .leading, spacing: Constants.UI.standardSpacing) {
            Text("Size preview")
                .font(.headline)

            HStack(spacing: 20) {
                ForEach(Constants.UI.SizePreview.labels.indices, id: \.self) { index in
                    sizePreviewCell(
                        displaySize: Constants.UI.SizePreview.displaySizes[index],
                        label: Constants.UI.SizePreview.labels[index]
                    )
                }
            }
        }
        .padding(Constants.UI.standardPadding)
        .background(Color(uiColor: .secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: Constants.UI.cornerRadius, style: .continuous))
    }

    private func sizePreviewCell(displaySize: CGFloat, label: String) -> some View {
        VStack(spacing: 8) {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(width: displaySize, height: displaySize)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

            Text(label)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
        }
    }
}

struct IconSizePreviewView_Previews: PreviewProvider {
    static var previews: some View {
        if let image = UIImage(systemName: "app.fill") {
            IconSizePreviewView(image: image)
                .padding()
                .previewLayout(.sizeThatFits)
        }
    }
}
