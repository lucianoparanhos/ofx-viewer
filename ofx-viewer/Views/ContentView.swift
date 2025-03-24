//
//  ContentView.swift
//  ofx-viewer
//
//  Created by Luciano Paranhos on 23/03/25.
//

import SwiftUI
import AppKit

struct ContentView: View {
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



@MainActor
func animateWindowResize(to newSize: NSSize) {
    if let window = NSApp.mainWindow {
        let currentFrame = window.frame
        let newOrigin = NSPoint(
            x: currentFrame.origin.x + (currentFrame.size.width - newSize.width) / 2,
            y: currentFrame.origin.y + (currentFrame.size.height - newSize.height) / 2
        )
        
        let newFrame = NSRect(origin: newOrigin, size: newSize)
        
        NSAnimationContext.runAnimationGroup({ context in
            context.duration = 0.3 // Tempo da animação em segundos
            context.allowsImplicitAnimation = true
            window.setFrame(newFrame, display: true, animate: true)
        }, completionHandler: nil)
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
    ContentView()
}
