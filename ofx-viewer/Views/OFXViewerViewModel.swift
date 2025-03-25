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
    func carregarArquivo(url: URL) {
        fileName = url.lastPathComponent
        appState = .fileLoaded
        
        if let window = NSApp.windows.first {
            window.title = ""
            // Não usamos .hidden no titleVisibility para preservar a altura padrão da toolbar
            window.representedURL = url
        }
        
        Task {
            try? await Task.sleep(nanoseconds: 100_000_000) // 0.1 segundos
            animateWindowResize(to: NSSize(width: 1024, height: 768))
        }
    }

    @MainActor
    func configurarJanelaInicial() {
        guard let window = NSApp.windows.first else { return }

        window.setContentSize(NSSize(width: 720, height: 450))

        if appState == .idle {
            window.title = NSLocalizedString("window-title", comment: "Título da janela principal")
        }

        if let screenFrame = NSScreen.main?.visibleFrame {
            let windowSize = window.frame.size
            let origin = NSPoint(
                x: screenFrame.midX - windowSize.width / 2,
                y: screenFrame.midY - windowSize.height / 2
            )
            window.setFrameOrigin(origin)
        }
    }
}
