//
//  LanguageViewModel.swift
//  BCAMusicPlayer
//
//  Created by Ray on 26/06/23.
//

import Foundation
import SwiftUI

class LanguageViewModel: ObservableObject {
   
    @Published var language: String = (UserDefaults.standard.string(forKey: "language") ?? "id") {
        didSet {
            UserDefaults.standard.set(language, forKey: "language")
        }
    }
    
    func toggleLanguage() {
        var lang = getLanguage()
        switch lang {
        case .indonesian: self.language = "en"
        case .english: self.language = "id"
        }
    }
    
    func getLanguage() -> Language {
        switch language {
        case "en": return .english
        case "id": return .indonesian
        default:
            return .indonesian
        }
    }
}
