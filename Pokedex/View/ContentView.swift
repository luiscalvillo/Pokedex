//
//  ContentView.swift
//  Pokedex
//
//  Created by Luis Calvillo on 3/19/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm = ViewModel()
    
    var body: some View {
        NavigationView {
           
            Text("Hello, world!")
        }
        .environmentObject(vm)
    }
}

#Preview {
    ContentView()
}
