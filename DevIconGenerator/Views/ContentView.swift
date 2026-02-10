//
//  ContentView.swift
//  DevIconGenerator
//
//  Created by Manuel Duarte on 6/6/25.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        switch horizontalSizeClass {
        case .regular:
            desktopLayout
        default:
            mobileLayout
        }
    }
    
    private var desktopLayout: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 20) {
                Text("DEV Icon Generator")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                
                Divider()
                
                Text("Platform Options")
                    .font(.headline)
                    .padding(.top, 10)
                
                PlatformOptionsView(
                    isExportingToiPhone: $viewModel.isExportingToiPhone,
                    isExportingToiPad: $viewModel.isExportingToiPad,
                    isExportingToMac: $viewModel.isExportingToMac,
                    isExportingToWatch: $viewModel.isExportingToWatch,
                    isDisabled: viewModel.isToggleOptionsDisabled
                )
                .padding(.leading, 10)
                
                Spacer()
                
                ExportButton(
                    action: { viewModel.export() },
                    isDisabled: viewModel.isExportButtonDisabled,
                    fullWidth: true
                )
                .padding(.bottom, 20)
            }
            .frame(width: 250)
            .padding(.horizontal)
            .background(Color(uiColor: .secondarySystemBackground))
            
            VStack(spacing: Constants.UI.standardSpacing) {
                Spacer()

                iconView
                    .frame(width: 300, height: 300)

                if let image = viewModel.selectedImage {
                    IconSizePreviewView(image: image)
                }

                if viewModel.isExportingInProgress {
                    StatusMessageView(type: .progress, showProgress: true)
                }

                if case let .failure(error) = viewModel.exportingPhase {
                    StatusMessageView(type: .error(error))
                }

                if case .completed = viewModel.exportingPhase {
                    StatusMessageView(type: .success)
                }

                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(Color(uiColor: .systemBackground))
        }
        .toolbar {
            #if targetEnvironment(macCatalyst)
            ToolbarItem(placement: .primaryAction) {
                Button("Open Image") {
                    viewModel.importImage()
                }
                .keyboardShortcut("o", modifiers: .command)
            }
            ToolbarItem(placement: .primaryAction) {
                Button("Export") {
                    viewModel.export()
                }
                .keyboardShortcut("e", modifiers: .command)
                .disabled(viewModel.isExportButtonDisabled)
            }
            #endif
        }
        .animation(.default, value: viewModel.exportingPhase)
        .animation(.default, value: viewModel.selectedImage)
        .fullScreenCover(isPresented: $viewModel.isPresentingImagePicker) {
            ImagePickerView(image: $viewModel.selectedImage)
        }
    }
    
    private var mobileLayout: some View {
        VStack(spacing: Constants.UI.standardSpacing) {
            iconView

            if let image = viewModel.selectedImage {
                IconSizePreviewView(image: image)
            }

            if viewModel.isExportingInProgress {
                StatusMessageView(type: .progress, showProgress: true)
            }

            if case let .failure(error) = viewModel.exportingPhase {
                StatusMessageView(type: .error(error))
            }

            if case .completed = viewModel.exportingPhase {
                StatusMessageView(type: .success)
            }
            exportView
        }
        .background(Color(uiColor: .systemBackground))
        .padding()
        .toolbar {
            #if targetEnvironment(macCatalyst)
            ToolbarItem(placement: .primaryAction) {
                Button("Open Image") {
                    viewModel.importImage()
                }
                .keyboardShortcut("o", modifiers: .command)
            }
            ToolbarItem(placement: .primaryAction) {
                Button("Export") {
                    viewModel.export()
                }
                .keyboardShortcut("e", modifiers: .command)
                .disabled(viewModel.isExportButtonDisabled)
            }
            #endif
        }
        .animation(.default, value: viewModel.exportingPhase)
        .animation(.default, value: viewModel.selectedImage)
        .fullScreenCover(isPresented: $viewModel.isPresentingImagePicker) {
            ImagePickerView(image: $viewModel.selectedImage)
        }
    }
    
    private var iconView: some View {
        IconPreviewView(
            image: viewModel.selectedImage,
            onTap: { self.viewModel.importImage() },
            isDisabled: viewModel.isExportingInProgress
        )
        .onDrop(of: ["public.image"], isTargeted: nil, perform: viewModel.handleOnDropProviders)
    }
    
    @ViewBuilder
    private var exportView: some View {
        Divider()
        PlatformOptionsView(
            isExportingToiPhone: $viewModel.isExportingToiPhone,
            isExportingToiPad: $viewModel.isExportingToiPad,
            isExportingToMac: $viewModel.isExportingToMac,
            isExportingToWatch: $viewModel.isExportingToWatch,
            isDisabled: viewModel.isToggleOptionsDisabled
        )
        
        Divider()
        
        ExportButton(
            action: { viewModel.export() },
            isDisabled: viewModel.isExportButtonDisabled
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

