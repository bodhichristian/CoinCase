//
//  UIApplication-Extension.swift
//  CoinCase
//
//  Created by christian on 11/30/22.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
