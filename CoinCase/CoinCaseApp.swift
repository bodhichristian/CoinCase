//
//  CoinCaseApp.swift
//  CoinCase
//
//  Created by christian on 11/28/22.
//

import SwiftUI

@main
struct CoinCaseApp: App {
    @StateObject private var viewModel = HomeViewModel()
    
    init() {
        //overrides default foreground color for navigation bar text attributes
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]

    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(viewModel)
        }
    }
}
