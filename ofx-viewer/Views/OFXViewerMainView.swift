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
            
            if viewModel.appState == .idle {
                OFXIdleView(viewModel: viewModel)
            } else {
                OFXFileLoadedView(searchText: $searchText)
            }
            
        }
        .onAppear {
            viewModel.configurarJanelaInicial()
        }
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(action: {
                    viewModel.carregarArquivo(nome: "Selecionado_via_menu.ofx")
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
