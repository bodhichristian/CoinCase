//
//  String.swift
//  CoinCase
//
//  Created by christian on 1/2/23.
//

import Foundation


extension String {
    
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
