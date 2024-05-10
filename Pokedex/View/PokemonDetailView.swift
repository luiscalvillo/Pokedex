//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Luis Calvillo on 3/19/24.
//

import SwiftUI

struct PokemonDetailView: View {
    
    @EnvironmentObject var vm: ViewModel
    
    @State private var showDetailView: Bool = true
    
    let pokemon: Pokemon

    var body: some View {
        
        VStack {
            
            PokemonView(showDetailView: $showDetailView, pokemon: pokemon)
           
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("\(vm.pokemonDetails?.types.first?.type.name.uppercased() ?? "")")
                            .font(.title3)
                            .padding(8)
                            .frame(width: 100, height: 40)
                            .background(.gray)
                            .cornerRadius(20)
                        Text("\(vm.pokemonDetails?.types.first?.type.name.uppercased() ?? "")")
                            .font(.title3)
                            .padding(8)
                            .frame(width: 100, height: 40)
                            .background(.gray)
                            .cornerRadius(20)
                    }
                    
                    Text("# \(vm.pokemonDetails?.id ?? 0)")
                        .font(.title)
                
                    Text("\(vm.species?.flavorTextEntries.first?.flavorText ?? "")")
                        .font(.title)
                        .lineLimit(4)
                    
                    Text("Weight")
                        .multilineTextAlignment(.leading)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("\(vm.formatHeightWeight(value: vm.pokemonDetails?.weight ?? 0)) KG")
                        .font(.title)
                    
                    Text("Height")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("\(vm.formatHeightWeight(value: vm.pokemonDetails?.height ?? 0)) M")
                        .font(.title)
            
                    Text("Catch Rate")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("\(vm.species?.captureRate ?? 0)")
                        .font(.title)
                }
                .frame(maxWidth: .infinity)
                
                Spacer()
            }
        .onAppear {
            vm.getDetails(pokemon: pokemon)
            vm.getSpecies(pokemon: pokemon)
        }
    }
}


#Preview {
    PokemonDetailView(pokemon: Pokemon.samplePokemon)
        .environmentObject(ViewModel())
}
