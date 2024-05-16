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
    
    @State var statName: String = "HP"
    @State var screenBounds = UIScreen.main.bounds.width
    
    var body: some View {
        
        let pokemonType1 = vm.pokemonDetails?.types.first?.type.name
        let pokemonType2 = vm.pokemonDetails?.types.last?.type.name
        let pokemonTypeCount = vm.pokemonDetails?.types.count
        
        let pokemonTypeHeight: CGFloat = 40
        let pokemonTypeWidth: CGFloat = 140
        let screenWidth = UIScreen.main.bounds.width + 200
        
        ScrollView {
            VStack {
                ZStack {
                    WaterShape()
                        .fill(getPokemonBackgroundGradient(type: pokemonType1 ?? ""))
                        .ignoresSafeArea()
                        .frame(maxWidth: .infinity)
                        .frame(height: screenWidth)
                    
                    VStack(alignment: .leading) {
                        
                        PokemonView(showDetailView: $showDetailView, pokemon: pokemon)
                        
                        Text("# \(vm.pokemonDetails?.id ?? 0)")
                            .font(.title)
                            .padding(.leading, 16)
                            .foregroundColor(.gray)
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
                        
                        Text("Stats")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        if let stats = vm.pokemonDetails?.stats {
                            ForEach(stats) { stat in
                                StatBarView(statName: stat.stat.name, statValue: stat.baseStat, maxValue: 100, screenBounds: $screenBounds)
                            }
                        }
                        else {
                            Text("No stats available")
                        }
                        
                        // MARK: - Species Description
                        
                        Text("\(vm.species?.flavorTextEntries.first?.flavorText.replacingOccurrences(of: "\n", with: " ").replacingOccurrences(of: "\u{0C}", with: " ") ?? "")")
                            .font(.title2)
                            .lineLimit(4)
                            .frame(height: 100)
                    
                        Text("Characteristics")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("Weight")
                            .multilineTextAlignment(.leading)
                            .font(.title)
                            .foregroundColor(convertPokemonTypeToAColor(type: pokemonType1 ?? ""))
                            .fontWeight(.bold)
                        
                        Text("\(vm.formatHeightWeight(value: vm.pokemonDetails?.weight ?? 0)) KG")
                            .font(.title)
                        
                        Text("Height")
                            .font(.title)
                            .foregroundColor(convertPokemonTypeToAColor(type: pokemonType1 ?? ""))
                            .fontWeight(.bold)
                        
                        Text("\(vm.formatHeightWeight(value: vm.pokemonDetails?.height  ?? 0)) M")
                            .font(.title)
                        
                        Text("Catch Rate")
                            .font(.title)
                            .foregroundColor(convertPokemonTypeToAColor(type: pokemonType1 ?? ""))
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


struct StatBarView: View {
    
    let statName: String
    let statValue: Int
    let maxValue: Int
    @Binding var  screenBounds: CGFloat
    
    var body: some View {
        HStack {
            Text(statName)
                .frame(width: 50, alignment: .leading)
            Text("\(statValue)")
                .frame(width: 50, alignment: .leading)
            
            ZStack(alignment: .leading) {
                
                // Background rectangle bar for the max value
                Rectangle()
                    .frame(width: screenBounds - 140, height: 20)
                    .foregroundColor(Color(.systemGray5))
                    .cornerRadius(10)
                
                // Foreground rectangle bar
                Rectangle()
                    .frame(width: CGFloat(statValue / maxValue) * screenBounds, height: 20)
                    .foregroundColor(.blue)
                    .cornerRadius(10)
            }
        }
        .padding(.vertical, 0)
        .cornerRadius(10)
    }
}
