//
//  OFXFileLoadedView.swift
//  ofx-viewer
//
//  Created by Luciano Paranhos on 24/03/25.
//

import SwiftUI

struct OFXFileLoadedView: View {
    @Binding var searchText: String
    
    var body: some View {
        VStack {
            HStack {
                EmptyView()
            }
        }
        .searchable(text: $searchText, placement: .toolbar)
    }
}

