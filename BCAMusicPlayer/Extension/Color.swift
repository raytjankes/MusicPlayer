//
//  Color.swift
//  BCAMusicPlayer
//
//  Created by Ray on 26/06/23.
//

import SwiftUI

extension Color {
    
    static let customPrimary = Color(hex: "0x32CCD1")
    static let customSecondary = Color(hex: "0x27C4C7")
    static let customText = Color(hex: "0x081F42")
    static let customHighlight = Color(hex: "0xFFFFFF")
    static let customButton = Color(hex: "0x283FFF")
    static let customDisabledButton = Color(hex: "0x8993A4")
    
    
    // Function to convert hexcode to Color
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = Double(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
    
}
