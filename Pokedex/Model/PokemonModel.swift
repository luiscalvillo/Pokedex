//
//  PokemonModel.swift
//  Pokedex
//
//  Created by Luis Calvillo on 3/19/24.
//

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
    let stats: [Stats]
}

struct PokemonColor: Codable {
    let name: String
}


// MARK: - Pokemon Type

struct TypeElement: Codable{
    let slot: Int
    let type: PokemonType
}

struct PokemonType: Codable {
    let name: String
}

// Species information
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

// Pokemon description
struct FlavorTextEntries: Codable {
    let flavorText: String
    
    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
    }
}

enum AllPokemonTypes: String {
    case bug
    case dragon
    case electric
    case fairy
    case fighting
    case fire
    case flying
    case ghost
    case grass
    case ground
    case ice
    case normal
    case poison
    case psychic
    case rock
    case steel
    case water
}

func convertPokemonTypeToAColor(type: AllPokemonTypes) -> Color {
    switch type {
    case AllPokemonTypes.bug:
        return .teal
    case AllPokemonTypes.dragon:
        return .mint
    case AllPokemonTypes.electric:
        return .yellow
    case AllPokemonTypes.fairy:
        return .pink
    case AllPokemonTypes.fighting:
        return .orange
    case AllPokemonTypes.fire:
        return .red
    case AllPokemonTypes.flying:
        return .cyan
    case AllPokemonTypes.ghost:
        return Color(UIColor.purple)
    case AllPokemonTypes.grass:
        return .green
    case AllPokemonTypes.ground:
        return .brown
    case AllPokemonTypes.ice:
        return .mint
    case AllPokemonTypes.normal:
        return .gray
    case AllPokemonTypes.poison:
        return .purple
    case AllPokemonTypes.psychic:
        return .indigo
    case AllPokemonTypes.rock:
        return Color(UIColor.darkGray)
    case AllPokemonTypes.steel:
        return Color(UIColor.lightGray)
    case AllPokemonTypes.water:
        return .blue
    default:
        return .gray
    }
}

func getPokemonBackgroundGradient(type: AllPokemonTypes) -> LinearGradient {
    switch type {
    case AllPokemonTypes.bug:
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)),Color(#colorLiteral(red: 0, green: 0.9810667634, blue: 0.5736914277, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    case AllPokemonTypes.dragon:
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1)),Color(#colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    case AllPokemonTypes.electric:
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)),Color(#colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    case AllPokemonTypes.fairy:
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1)),Color(#colorLiteral(red: 0.8446564078, green: 0.5145705342, blue: 1, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    case AllPokemonTypes.fighting:
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5787474513, green: 0.3215198815, blue: 0, alpha: 1)),Color(#colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    case AllPokemonTypes.fire:
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)),Color(#colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    case AllPokemonTypes.flying:
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1)),Color(#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    case AllPokemonTypes.ghost:
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)),Color(#colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    case AllPokemonTypes.grass:
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)),Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    case AllPokemonTypes.ground:
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1)),Color(#colorLiteral(red: 0.5787474513, green: 0.3215198815, blue: 0, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    case AllPokemonTypes.ice:
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)),Color(#colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    case AllPokemonTypes.normal:
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)),Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    case AllPokemonTypes.poison:
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5808190107, green: 0.0884276256, blue: 0.3186392188, alpha: 1)),Color(#colorLiteral(red: 1, green: 0.5212053061, blue: 1, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    case AllPokemonTypes.psychic:
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3236978054, green: 0.1063579395, blue: 0.574860394, alpha: 1)),Color(#colorLiteral(red: 1, green: 0.5409764051, blue: 0.8473142982, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    case AllPokemonTypes.rock:
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)),Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    case AllPokemonTypes.steel:
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)),Color(#colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)),Color(#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)),Color(#colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)), Color(#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    case AllPokemonTypes.water:
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)),Color(#colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    default:
        return LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)),Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}


// MARK: - Pokemon Stats

struct Stats: Codable, Identifiable {
    let id = UUID()
    let baseStat: Int
    let stat: Stat
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat = "stat"
    }
}

struct Stat: Codable {
    let name: String
}
