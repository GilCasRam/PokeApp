//
//  PokeballLoader.swift
//  PokeApp
//
//  Created by Gil CasRam on 21/07/25.
//

import SwiftUI

struct PokeballLoader: View {
    @State private var scale: CGFloat = 1.0

    var body: some View {
        VStack {
            Image("pokeball-logo-png_seeklogo-286475")
                .resizable()
                .clipShape(Circle())
                .frame(width: 60, height: 60)
                .scaleEffect(scale)
                .animation(
                    .easeInOut(duration: 0.8).repeatForever(autoreverses: true),
                    value: scale
                )
                .onAppear {
                    scale = 1.2
                }
        }
    }
}

#Preview {
    PokeballLoader()
}
