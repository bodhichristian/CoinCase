//
//  LaunchView.swift
//  CoinCase
//
//  Created by christian on 1/1/23.
//

import SwiftUI

struct LaunchView: View {
    @State private var loadingText: [String] = "Loading your portfolio...".map { String($0) }
    @State private var showingLoadingText = false
    
    @State private var counter: Int = 0
    @State private var loops: Int = 0
    @Binding var showingLaunchView: Bool
    
    let timer = Timer.publish(every: 0.06, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.launch.background
                .ignoresSafeArea()
            
            Image("logo-transparent")
                .resizable()
                .frame(width: 100, height: 100)
            
            ZStack {
                if showingLoadingText {
                 
                    HStack(spacing: 0) {
                        ForEach(loadingText.indices) { index in
                            Text(loadingText[index])
                                .font(.headline)
                                .foregroundColor(.launch.accent)
                                .offset(y: counter == index ? -10 : 0)
                        }
                    }
                    .transition(AnyTransition.scale.animation(.easeIn.speed(1.7)))
                }
            }
            .offset(y: 70)
        }
        .onAppear {
            showingLoadingText.toggle()
        }
        .onReceive(timer) { _ in
            withAnimation(.spring()) {
                let lastIndex = loadingText.count - 1
                
                if counter == lastIndex {
                    counter = 0
                    loops += 1
                    if loops >= 2 {
                        showingLaunchView = false
                    }
                } else {
                    counter += 1
                }
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showingLaunchView: .constant(true))
    }
}
