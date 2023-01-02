//
//  SettingsView.swift
//  CoinCase
//
//  Created by christian on 12/30/22.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.dismiss) var dismiss
    
    let defaultURL = URL(string: "https://www.google.com")!
    let youtubeURL = URL(string: "https://www.youtube.com/c/swiftfulthinking")!
    let coffeeURL = URL(string: "https://www.buymeacoffee.com/nicksarno")!
    let coingeckoURL = URL(string: "https://wwww.coingecko.com")!
    let githubURL = URL(string: "https://www.github.com/bodhichristian")!
    let twitterURL = URL(string: "https://twitter.com/bodhichristian")!
    
    var body: some View {
        NavigationView {
            List {
                developerCredits
                swiftfulThinkingCredits
                coinGeckoCredits
                appLinks
            }
            
            .tint(.blue)
            .listStyle(GroupedListStyle())
            .navigationTitle("Info")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        XMarkButton()
                    }
                }
            })
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}

extension InfoView {
    
    private var swiftfulThinkingCredits: some View {
        Section {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was made following a @SwiftfulThinking course on YouTube. It uses MVVM architecture, Combine, and Core Data.")
                    .font(.callout)
                    //.foregroundColor(.theme.accent)
            }
            .padding(.vertical, 4)
            Link("Subscribe on YouTube", destination: youtubeURL)
            Link("Buy Nick a cup of coffee ☕️", destination: coffeeURL)
        } header: {
            Text("Swiftful Thinking")
        }
    }
    
    private var coinGeckoCredits: some View {
        Section {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .frame(height: 100)
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("The cryptocurrency data used in this app is provided by a free API from CoinGecko. Pirce data may be slightly delayed.")
                    .font(.callout)
                    //.foregroundColor(.theme.accent)
            }
            .padding(.vertical, 4)
            Link("CoinGecko.com", destination: coingeckoURL)
        } header: {
            Text("Swiftful Thinking")
        }
    }
    
    private var developerCredits: some View {
        Section {
            VStack(alignment: .leading) {
                Image("christian")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 110)
                    .clipShape(Circle())
                Text("CoinCase was developed by Christian Lavelle. It uses Swift and SwiftUI, and benefits from multi-threading, publishers & subscribers, and data persistance.")
                    .font(.callout)
                    //.foregroundColor(.theme.accent)
            }
            .padding(.vertical, 4)
            Link("GitHub", destination: githubURL)
            Link("Twitter", destination: twitterURL)
        } header: {
            Text("Developer")
        }
    }
    
    private var appLinks: some View {
        Section {
        Link("Terms of Service", destination: defaultURL)
        Link("Privacy Policy", destination: defaultURL)
        Link("CoinCase Website", destination: defaultURL)
        Link("Learn More", destination: defaultURL)
            
        } header: {
            Text("CoinCase info")
        }

    }
}
