//
//  launchscreen.swift
//  iOS_Pokedex
//
//  Created by Joshua Mandelson on 1/29/26.
//

import SwiftUI

struct LaunchScreen: View {
    @State private var isActive = false

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            if isActive {
                CreaturesListView()
            } else {
                Image("pokemon")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isActive = true
            }
        }
    }
}

#Preview {
    LaunchScreen()
}

