//
//  Color.swift
//  CoinCase
//
//  Created by christian on 11/28/22.
//

import Foundation
import SwiftUI

extension Color {
    
    static let theme = ColorTheme()
    static let launch = LaunchTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
}

struct LaunchTheme {
    let accent = Color("LaunchAccentColor")
    let background = Color("LaunchBackgroundColor")
    
}



//struct ColorTheme2 {
//    let accent = Color("AccentColor")
//    let background = Color("BackgroundColor")
//    let green = Color("GreenColor")
//    let red = Color("RedColor")
//    let secondaryText = Color("SecondaryTextColor")
//}
