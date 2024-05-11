//
//  PokemonModel.swift
//  Pokedex
//
//  Created by Luis Calvillo on 3/19/24.
//

import Foundation
import SwiftUI

struct PokemonPage: Codable {
    let count: Int
    let next: String
    let results: [Pokemon]
}

struct Pokemon: Codable, Identifiable, Equatable {
    let id = UUID()
    let name: String
    let url: String
        
    static var samplePokemon = Pokemon(name: "Bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
}

struct DetailPokemon: Codable {
    let id: Int
    let height: Int
    let weight: Int
    let types: [TypeElement]
}

struct PokemonColor: Codable {
    let name: String
}

struct FlavorTextEntries: Codable {
    let flavorText: String
    
    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
    }
}

// MARK: - Pokemon Type

struct TypeElement: Codable{
    let slot: Int
    let type: PokemonType
}

struct PokemonType: Codable {
    let name: String
}

struct Species: Codable {
    let captureRate: Int
    let color: PokemonColor
    let flavorTextEntries: [FlavorTextEntries]
    
    enum CodingKeys: String, CodingKey {
        case captureRate = "capture_rate"
        case flavorTextEntries = "flavor_text_entries"
        case color
    }
    
    static let sampleSpecies = Species(captureRate: 123, color: PokemonColor.init(name: "white"), flavorTextEntries: [FlavorTextEntries.init(flavorText: "text")] )
}

enum ListOfPokemonTypes: String {
    case bug
    case dragon
    case electric
    case fairy
    case fighting
    case fire
    case flying
    case grass
    case ground
    case ice
    case normal
    case poison
    case psychic
    case rock
    case water
}


func convertPokemonTypeToAColor(type: String) -> Color {
    switch type {
    case "bug":
        return .pink
    case "dragon":
        return  .pink
    case "electric":
        return .yellow
    case "fairy":
        return .pink
    case "fighting":
        return .brown
    case "fire":
        return .red
    case "flying":
        return .cyan
    case "grass":
        return .green
    case "ground":
        return .brown
    case "ice":
        return .mint
    case "normal":
        return .gray
    case "poison":
        return .purple
    case "psychic":
        return .indigo
    case "rock":
        return .brown
    case "water":
        return .blue
    default:
        return  .gray
    }
}
