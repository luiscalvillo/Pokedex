//
//  ContentView.swift
//  Pokedex
//
//  Created by Luis Calvillo on 3/19/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm = ViewModel()
    
    @State private var showDetailView: Bool = false
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 120))
    ]
    
    
    init() {
        UINavigationBar.appearance().barTintColor = .red // Set navigation bar color
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white] // Set title color
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = .white
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: adaptiveColumns, spacing: 10){
                    ForEach(vm.filteredPokemon) { pokemon in
                        NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                            PokemonView(showDetailView: $showDetailView, pokemon: pokemon)
                        }
                    }
                }
                .background(.white)
                .animation(.easeIn(duration: 0.3), value: vm.filteredPokemon.count)
                .navigationTitle("Pokedex")
                .navigationBarTitleDisplayMode(.inline)
            }
            .background(.red)
            .searchable(text: $vm.searchText)
        }
        .environmentObject(vm)
    }
}

#Preview {
    ContentView()
}
