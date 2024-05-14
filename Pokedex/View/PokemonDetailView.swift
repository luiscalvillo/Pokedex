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
        
        let pokemonType1 = vm.pokemonDetails?.types.first?.type.name
        let pokemonType2 = vm.pokemonDetails?.types.last?.type.name
        let pokemonTypeCount = vm.pokemonDetails?.types.count
        
        let pokemonTypeHeight: CGFloat = 40
        let pokemonTypeWidth: CGFloat = 140
        
        ScrollView {
            VStack {
                ZStack {
                    WaterShape()
                        .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)),Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .ignoresSafeArea()
                        .frame(maxWidth: .infinity)
                        .frame(height: 500)
                    
                    VStack(alignment: .leading) {
                        
                        PokemonView(showDetailView: $showDetailView, pokemon: pokemon)
                        Text("# \(vm.pokemonDetails?.id ?? 0)")
                            .font(.title)
                            .padding(.leading, 16)
                            .foregroundColor(.secondary)
                    }
                }
                
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        
                        // MARK: - Pokemon Type
                        HStack {
                            if pokemonTypeCount == 1{
                                Text("\(pokemonType1?.uppercased() ?? "")")
                                    .font(.title3)
                                    .foregroundStyle(.white)
                                    .padding(8)
                                    .frame(width: pokemonTypeWidth, height: pokemonTypeHeight)
                                    .background(convertPokemonTypeToAColor(type: pokemonType1 ?? ""))
                                    .cornerRadius(20)
                            } else {
                                Text("\(pokemonType1?.uppercased() ?? "")")
                                    .font(.title3)
                                    .foregroundStyle(.white)
                                    .padding(8)
                                    .frame(width: pokemonTypeWidth, height: pokemonTypeHeight)
                                    .background(convertPokemonTypeToAColor(type: pokemonType1 ?? ""))
                                    .cornerRadius(20)
                                Text("\(pokemonType2?.uppercased() ?? "")")
                                    .font(.title3)
                                    .foregroundStyle(.white)
                                    .padding(8)
                                    .frame(width: pokemonTypeWidth, height: pokemonTypeHeight)
                                    .background(convertPokemonTypeToAColor(type: pokemonType2 ?? ""))
                                    .cornerRadius(20)
                            }
                        }
                        
                        // MARK: - Species Description
                        
                        Text("\(vm.species?.flavorTextEntries.first?.flavorText.replacingOccurrences(of: "\n", with: " ").replacingOccurrences(of: "\u{0C}", with: " ") ?? "")")
                            .font(.title2)
                            .lineLimit(4)
                            .frame(height: 100)
                        
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
                    Spacer()
                }
                .padding(16)
            }
            .onAppear {
                vm.getDetails(pokemon: pokemon)
                vm.getSpecies(pokemon: pokemon)
            }
        }
        .background(.white)
        .foregroundColor(.black)
    }
}

struct WaterShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.midY),
                              control: CGPoint(x: rect.width * 0.25, y: rect.height * 0.60))
            path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midY),
                              control: CGPoint(x: rect.width * 0.75, y: rect.height * 0.40))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        }
    }
}


#Preview {
    PokemonDetailView(pokemon: Pokemon.samplePokemon)
        .environmentObject(ViewModel())
}
