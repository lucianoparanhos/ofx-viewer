//
//  OFXIdleView.swift
//  ofx-viewer
//
//  Created by Luciano Paranhos on 24/03/25.
//

import SwiftUI
import UniformTypeIdentifiers

typealias FileSelectionHandler = (String) -> Void

struct OFXIdleView: View {
    @ObservedObject var viewModel: OFXViewerViewModel

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "arrow.down.document")
                .resizable()
                .scaledToFit()
                .frame(width: 64, height: 64)
                .foregroundStyle(.secondary)

            Text("Nenhum arquivo carregado. Selecione um arquivo para continuar.")
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button("Selecionar Arquivo") {
                let panel = NSOpenPanel()
                panel.allowedContentTypes = [UTType(filenameExtension: "ofx")!]
                panel.allowsMultipleSelection = false
                panel.canChooseDirectories = false
                panel.begin { response in
                    if response == .OK, let url = panel.url {
                        viewModel.carregarArquivo(url: url)
                    }
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .onDrop(of: [.fileURL], isTargeted: nil) { providers in
            handleDrop(providers: providers)
        }
    }

    func handleDrop(providers: [NSItemProvider]) -> Bool {
        for provider in providers {
            if provider.hasItemConformingToTypeIdentifier("public.file-url") {
                provider.loadItem(forTypeIdentifier: "public.file-url", options: nil) { item, _ in
                    if let data = item as? Data,
                       let url = URL(dataRepresentation: data, relativeTo: nil),
                       url.pathExtension.lowercased() == "ofx" {
                        Task { @MainActor in
                            viewModel.carregarArquivo(url: url)
                        }
                    }
                }
                return true
            }
        }
        return false
    }
}
