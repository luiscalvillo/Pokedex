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


func getPokemonBackgroundGradient(type: String) -> LinearGradient {
    switch type {
    case "bug":
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)),Color(#colorLiteral(red: 0, green: 0.9810667634, blue: 0.5736914277, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    case "dragon":
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1)),Color(#colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    case "electric":
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)),Color(#colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    case "fairy":
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1)),Color(#colorLiteral(red: 0.8446564078, green: 0.5145705342, blue: 1, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    case "fighting":
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5787474513, green: 0.3215198815, blue: 0, alpha: 1)),Color(#colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    case "fire":
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)),Color(#colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    case "flying":
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1)),Color(#colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    case "grass":
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)),Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    case "ground":
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5787474513, green: 0.3215198815, blue: 0, alpha: 1)),Color(#colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    case "ice":
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)),Color(#colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    case "normal":
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)),Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    case "poison":
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5808190107, green: 0.0884276256, blue: 0.3186392188, alpha: 1)),Color(#colorLiteral(red: 1, green: 0.5212053061, blue: 1, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    case "psychic":
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3236978054, green: 0.1063579395, blue: 0.574860394, alpha: 1)),Color(#colorLiteral(red: 1, green: 0.5409764051, blue: 0.8473142982, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    case "rock":
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)),Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    case "water":
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)),Color(#colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    default:
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)),Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
