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
    @State private var showingLaunchView = true
    
    init() {
        //overrides default foreground color for navigation bar text attributes
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UITableView.appearance().backgroundColor = UIColor.clear
        
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationView {
                    HomeView()
                        .navigationBarHidden(true)
                }
                .environmentObject(viewModel)
                
                
                ZStack {
                    if showingLaunchView {
                        LaunchView(showingLaunchView: $showingLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
            }
            
        }
    }
}
