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

                    ScrollView {
                        ForEach(creatures.creaturesArray, id: \.self) { creature in
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
                                HStack {
                                    Image("pokeball")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                    Spacer()
                                    Text(creature.name.capitalized)
                                        .font(.title2)
                                    Spacer()
                                }
                                .padding(5)
                                .background(Color.white.opacity(0.2))
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .padding(.horizontal)
                            }
                            .scrollTransition { content, phase in
                                content
                                    .opacity(phase.isIdentity ? 1 : 0.3)
                                    .offset(x: phase.isIdentity ? 0 : 300)
                            }
                        }

                        .navigationTitle("Pokedex")
                    }
                    .scrollIndicators(.hidden)
                    .scrollTargetLayout()
                    .scrollTargetBehavior(.viewAligned)
                    
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
