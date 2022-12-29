//
//  String.swift
//  CoinCase
//
//  Created by christian on 12/29/22.
//

import Foundation

// removes HTML in strings
extension String {
    var removeHTML: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
