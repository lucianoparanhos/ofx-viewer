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
                        viewModel.carregarArquivo(nome: url.lastPathComponent)
                        // Aqui você pode iniciar a leitura do arquivo
                    }
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
