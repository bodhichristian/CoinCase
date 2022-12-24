//
//  XMarkButton.swift
//  CoinCase
//
//  Created by christian on 12/1/22.
//

import SwiftUI

struct XMarkButton: View {
    
    var body: some View {
      
            Image(systemName: "xmark")
                .font(.caption2)
                .frame(width: 25, height: 25)
                .background(Color.theme.secondaryText.opacity(0.2))
                .clipShape(Circle())
                .offset(y: -2)
        }
    
}

struct XMarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XMarkButton()
    }
}
