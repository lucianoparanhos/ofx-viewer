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
                .ignoresSafeArea()
            
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
                window.title = NSLocalizedString("window-title", comment: "Título da janela principal")
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
