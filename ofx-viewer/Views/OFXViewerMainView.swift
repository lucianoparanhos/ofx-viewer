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
    
    var body: some View {
        ZStack {
            VisualEffectView(material: .underWindowBackground)
                .edgesIgnoringSafeArea(.all) // Garante que o fundo cubra toda a janela
            
            VStack {
                HStack {
                    EmptyView()
                }
                .buttonStyle(.bordered)
            }
            .frame(minWidth: 400, minHeight: 300)
        }
        .onAppear {
            if let window = NSApp.windows.first {
                window.title = "Visualizador OFX"
            }
        }
        .toolbar {
            ToolbarItem(placement: .automatic) {
                EmptyView()
            }
        }
        .searchable(text: $searchText, placement: .toolbar)
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
