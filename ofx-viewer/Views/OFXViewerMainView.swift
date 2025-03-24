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
    
    var body: some View {
        ZStack {
            VisualEffectView(material: .underWindowBackground)
                .ignoresSafeArea()
            
            if appState == .idle {
                VStack {
                    Image(systemName: "arrow.down.document")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 64, height: 64)
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 8)
                    
                    Text("Nenhum arquivo carregado. Clique no botão para carregar um arquivo.")
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Button("Selecionar Arquivo") {
                        fileName = "Nubank_2024-10-01.ofx"
                        appState = .fileLoaded
                        if let window = NSApp.windows.first {
                            window.title = fileName
                            animateWindowResize(to: NSSize(width: 1024, height: 768))
                        }
                    }
                    .padding()
                }
                .frame(minWidth: 720, minHeight: 450)
            } else {
                VStack {
                    HStack {
                        EmptyView()
                    }
                    .buttonStyle(.bordered)
                }
                .frame(minWidth: 720, minHeight: 450)
                .searchable(text: $searchText, placement: .toolbar)
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
                Text("")
                    .frame(width: 1)
                    .opacity(0) // invisível
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
