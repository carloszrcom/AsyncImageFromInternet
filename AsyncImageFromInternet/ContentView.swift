//
//  ContentView.swift
//  AsyncImageFromInternet
//
//  Created by Carlos ZR on 3/3/22.
//

import SwiftUI

extension Image {
    func imagenModifier() -> some View {
        self
            .resizable()
            .scaledToFit()
    }
    
    func iconoModifier() -> some View {
        self
            .imagenModifier()
            .frame(maxWidth: 128)
            .foregroundColor(.purple)
            .opacity(0.5)
    }
}

struct ContentView: View {
    private let imagen: String = "https://cdn.pixabay.com/photo/2020/03/04/15/37/landscape-4901883_960_720.jpg"
    
    var body: some View {
        
        // MARK: - ASYNCIMAGE
        
        AsyncImage(
            url: URL(string: imagen),
            transaction: Transaction(animation: .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25))
        ) { phase in
            switch phase {
            case .success(let image):
                image
                    .imagenModifier()
                    .transition(.slide)
            case .failure(_):
                Image(systemName: "ant.circle.fill").iconoModifier()
            case .empty:
                Image(systemName: "photo.circle.fill").iconoModifier()
            @unknown default:
                ProgressView()
            }
        }
        .padding(25)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
