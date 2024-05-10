//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Luis Calvillo on 3/19/24.
//

import SwiftUI

struct PokemonCell: View {
    var body: some View {
        ZStack {
            VStack {
                Text("Bulbasaur")
                HStack {
                    Text("Poisen")
                }
            }
        }
    }
}

#Preview {
    PokemonCell()
}
