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
    
    // Desktop layout with sidebar design
    private var desktopLayout: some View {
        HStack(spacing: 0) {
            // Sidebar
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
                
                VStack(alignment: .leading, spacing: 12) {
                    Toggle("iPhone", isOn: $viewModel.isExportingToiPhone)
                    Toggle("iPad", isOn: $viewModel.isExportingToiPad)
                    Toggle("Mac", isOn: $viewModel.isExportingToMac)
                    Toggle("Apple Watch", isOn: $viewModel.isExportingToWatch)
                }
                .disabled(viewModel.isToggleOptionsDisabled)
                .padding(.leading, 10)
                
                Spacer()
                
                Button {
                    viewModel.export()
                } label: {
                    Label("Export Icons", systemImage: "square.and.arrow.up")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .disabled(viewModel.isExportButtonDisabled)
                .padding(.bottom, 20)
            }
            .frame(width: 250)
            .padding(.horizontal)
            .background(Color(uiColor: .secondarySystemBackground))
            
            // Main content area
            VStack {
                Spacer()
                
                iconView
                    .frame(width: 300, height: 300)
                
                if viewModel.isExportingInProgress {
                    ProgressView("Generating icons...")
                        .padding()
                }
                
                if case let .failure(error) = viewModel.exportingPhase {
                    Text(error.localizedDescription)
                        .foregroundColor(.red)
                        .padding()
                        .multilineTextAlignment(.center)
                }
                
                if case .completed = viewModel.exportingPhase {
                    Text("Icons generated successfully!")
                        .foregroundColor(.green)
                        .padding()
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(Color(uiColor: .systemBackground))
        }
        .animation(.default, value: viewModel.exportingPhase)
        .animation(.default, value: viewModel.selectedImage)
        .fullScreenCover(isPresented: $viewModel.isPresentingImagePicker) {
            ImagePickerView(image: $viewModel.selectedImage)
        }
    }
    
    // Mobile layout (original design)
    private var mobileLayout: some View {
        VStack(spacing: 24) {
            iconView
            if viewModel.isExportingInProgress {
                ProgressView()
            }
            exportView
        }
        .background(Color(uiColor: .systemBackground))
        .padding()
        .animation(.default, value: viewModel.exportingPhase)
        .animation(.default, value: viewModel.selectedImage)
        .fullScreenCover(isPresented: $viewModel.isPresentingImagePicker) {
            ImagePickerView(image: $viewModel.selectedImage)
        }
    }
    
    private var iconView: some View {
        Button {
            self.viewModel.importImage()
        } label: {
            RoundedRectangle(cornerRadius: 24, style: .circular)
                .foregroundColor(.gray.opacity(0.5))
                .overlay {
                    if let selectedImage = viewModel.selectedImage {
                        Image(uiImage: selectedImage)
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
        .disabled(viewModel.isExportingInProgress)
        .onDrop(of: ["public.image"], isTargeted: nil, perform: viewModel.handleOnDropProviders)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
    
    @ViewBuilder
    private var exportView: some View {
        Divider()
        VStack {
            Toggle("iPhone", isOn: $viewModel.isExportingToiPhone)
            Toggle("iPad", isOn: $viewModel.isExportingToiPad)
            Toggle("Mac", isOn: $viewModel.isExportingToMac)
            Toggle("Apple Watch", isOn: $viewModel.isExportingToWatch)
        }
        .disabled(viewModel.isToggleOptionsDisabled)
        
        Divider()
        
        Button {
            viewModel.export()
        } label: {
            Text("Export")
        }
        .buttonStyle(BorderedProminentButtonStyle())
        .disabled(viewModel.isExportButtonDisabled)
        
        if case let .failure(error) = viewModel.exportingPhase {
            Text(error.localizedDescription)
                .foregroundColor(.red)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

