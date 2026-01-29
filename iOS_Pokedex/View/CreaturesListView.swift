//
//  ContentView.swift
//  iOS_Pokedex
//
//  Created by Joshua Mandelson on 1/26/26.
//

import SwiftUI

struct CreaturesListView: View {
    @State var creatures = Creatures()
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [
                    Color(red: 0/255, green: 50/255, blue: 100/255),
                    Color(.cyan)
                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
                List(creatures.creaturesArray, id: \.self) { creature in
                    NavigationLink {
                        DetailView(creature: creature)
                    } label: {
                        Text(creature.name.capitalized)
                            .font(.title2)
                    }
                    .listRowBackground(Color.clear) // 1. Makes the row background transparent
                }
                .foregroundStyle(.white)
                .scrollContentBackground(.hidden)
                .navigationTitle("Pokedex")
            }
        }
        .task {
            await creatures.getData()
        }
    }
}

#Preview {
    CreaturesListView()
}
