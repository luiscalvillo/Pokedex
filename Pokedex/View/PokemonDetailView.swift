//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Luis Calvillo on 3/19/24.
//

import SwiftUI

struct PokemonDetailView: View {
    
    @EnvironmentObject var vm: ViewModel
    let pokemon: Pokemon
    
    var body: some View {
        VStack {
            
            PokemonView(pokemon: pokemon)
            
            VStack(spacing: 10) {
                Text("**ID** \(vm.pokemonDetails?.id ?? 0)")
                Text("**Weight** \(vm.formatHeightWeight(value: vm.pokemonDetails?.weight ?? 0)) KG")
                Text("**Height** \(vm.formatHeightWeight(value: vm.pokemonDetails?.height ?? 0)) M")
            }
        }
        .onAppear {
            vm.getDetails(pokemon: pokemon)
        }
    }
}

#Preview {
    PokemonDetailView(pokemon: Pokemon.samplePokemon)
        .environmentObject(ViewModel())
}
