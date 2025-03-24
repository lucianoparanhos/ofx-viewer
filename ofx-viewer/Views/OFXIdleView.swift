//
//  OFXIdleView.swift
//  ofx-viewer
//
//  Created by Luciano Paranhos on 24/03/25.
//

import SwiftUI

typealias FileSelectionHandler = (String) -> Void

struct OFXIdleView: View {
    @ObservedObject var viewModel: OFXViewerViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "arrow.down.document") // Ícone central
            Text("Nenhum arquivo carregado...")
            Button("Selecionar Arquivo") {
                viewModel.fileName = "Nubank_2024-10-01.ofx"
                viewModel.appState = .fileLoaded
            }
        }
    }
}
