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
                viewModel.carregarArquivo(nome: "Nubank_2024-10-01.ofx")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
