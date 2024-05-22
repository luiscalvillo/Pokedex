//
//  TypeView.swift
//  Pokedex
//
//  Created by Luis Calvillo on 5/21/24.
//

import SwiftUI

struct TypeView: View {

    let pokemonType: String
    var width: CGFloat = 140
    var height: CGFloat = 40
    
    private var typeColor: Color {
        convertPokemonTypeToAColor(type: pokemonType)
    }
    
    var body: some View {
        Text("\(pokemonType.uppercased())")
            .font(.title3)
            .foregroundStyle(.white)
            .padding(8)
            .frame(width: width, height: height)
            .background(typeColor)
            .cornerRadius(20)
    }
}
