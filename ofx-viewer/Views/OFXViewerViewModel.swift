//
//  OFXViewerViewModel.swift
//  ofx-viewer
//
//  Created by Luciano Paranhos on 24/03/25.
//

import SwiftUI

class OFXViewerViewModel: ObservableObject {
    @Published var fileName: String = ""
    @Published var appState: AppState = .idle
    @Published var searchText: String = ""
    
    @MainActor
    func carregarArquivo(nome: String) {
        fileName = nome
        appState = .fileLoaded
        animateWindowResize(to: NSSize(width: 1024, height: 768))
    }
}
