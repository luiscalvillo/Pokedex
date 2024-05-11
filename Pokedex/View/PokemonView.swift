//
//  PokemonView.swift
//  Pokedex
//
//  Created by Luis Calvillo on 3/19/24.
//

import SwiftUI

struct PokemonView: View {
    
    @EnvironmentObject var vm: ViewModel
    
    @Binding var showDetailView: Bool
    
    let pokemon: Pokemon
    let dimensions: Double = 90
    let detailViewDimensions: Double = UIScreen.main.bounds.width
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(vm.getPokemonIndex(pokemon: pokemon)).png")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: showDetailView ? detailViewDimensions : dimensions, height: showDetailView ? detailViewDimensions : dimensions)
            } placeholder: {
                ProgressView()
                    .frame(width: showDetailView ? detailViewDimensions : dimensions, height: showDetailView ? detailViewDimensions : dimensions)
            }
//            .background(.white)
//            .clipShape(Circle())
            
            Text("\(pokemon.name.uppercased())")
                .font(showDetailView ? .title : .subheadline)
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                .padding(.bottom, 20)
        }
    }
}

#Preview {
    PokemonView(showDetailView: .constant(false), pokemon: Pokemon.samplePokemon).environmentObject(ViewModel())
}
