//
//  ContentView.swift
//  iOS_Pokedex
//
//  Created by Joshua Mandelson on 1/26/26.
//

import SwiftUI

struct CreaturesListView: View {
    @State var creatures = Creatures()
    @Environment(\.modelContext) private var modelContext
    @State private var teamVM: TeamViewModel?

    var body: some View {
        TabView {
            // Pokédex Tab
            NavigationStack {
                ZStack {
                    LinearGradient(
                        colors: [Color(red: 0/255, green: 50/255, blue: 100/255), Color(.cyan)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea()

                    List(creatures.creaturesArray, id: \.self) { creature in
                        NavigationLink {
                            if let teamVM {
                                DetailView(
                                    creatureURL: creature.url,
                                    pokemonId: creature.hashValue,
                                    name: creature.name,
                                    teamVM: teamVM
                                )
                            }
                        } label: {
                            Text(creature.name.capitalized)
                                .font(.title2)
                        }
                        .listRowBackground(Color.clear)
                    }
                    .foregroundStyle(.white)
                    .scrollContentBackground(.hidden)
                    .navigationTitle("Pokedex")
                }
            }
            .tabItem {
                Label("Pokédex", systemImage: "list.bullet")
            }

            // Team Tab
            if let teamVM {
                TeamView(teamVM: teamVM)
                    .tabItem {
                        Label("Team", systemImage: "person.3.fill")
                    }
            }
        }
        .onAppear {
            // Initialize TeamViewModel once
            if teamVM == nil {
                teamVM = TeamViewModel(modelContext: modelContext)
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
