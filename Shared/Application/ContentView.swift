//
//  ContentView.swift
//  Shared
//
//  Created by GoEun Jeong on 2021/08/21.
//

import SwiftUI

struct ContentView: View {
    #if os(iOS)
    var body: some View {
        Home()
    }
    
    #endif
    
    #if os(OSX)
    @ObservedObject var homeViewModel = HomeViewModel()
    var body: some View {
        
        Home()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .environmentObject(homeViewModel)
    }
    #endif
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}