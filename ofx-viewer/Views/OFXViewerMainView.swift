//
//  ContentView.swift
//  ofx-viewer
//
//  Created by Luciano Paranhos on 23/03/25.
//

import SwiftUI
import AppKit

struct OFXViewerMainView: View {
    @State private var searchText: String = ""
    
    @State private var appState: AppState = .idle
    @State private var fileName: String = ""
    
    @StateObject private var viewModel = OFXViewerViewModel()
    
    var body: some View {
        ZStack {
            VisualEffectView(material: .underWindowBackground)
                .ignoresSafeArea()
            
            if appState == .idle {
                OFXIdleView(viewModel: viewModel)
                
                
            } else {
                OFXFileLoadedView(searchText: $searchText)
            }
            
        }
        .onAppear {
            if let window = NSApp.windows.first {
                window.setContentSize(NSSize(width: 720, height: 450))

                if appState == .idle, let window = NSApp.windows.first {
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
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(action: {
                    // Aqui você pode abrir um painel para selecionar arquivos futuramente
                    fileName = "Selecionado_via_menu.ofx"
                    appState = .fileLoaded
                    if let window = NSApp.windows.first {
                        window.title = fileName
                        animateWindowResize(to: NSSize(width: 1024, height: 768))
                    }
                }) {
                    Label("Abrir OFX", systemImage: "arrow.down.document")
                }
            }
        }
    }
}

struct VisualEffectView: NSViewRepresentable {
    let material: NSVisualEffectView.Material
    
    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        view.material = material
        view.blendingMode = .behindWindow
        view.state = .active
        return view
    }
    
    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {}
}

#Preview {
    OFXViewerMainView()
}
