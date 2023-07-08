//
//  Audio.swift
//  BCAMusicPlayer
//
//  Created by Ray on 27/06/23.
//

import Foundation

class Audio: Hashable, Codable {
    private var id: UUID
    private var name: String
    private var time: String
    private var file: String
    
    init(name: String, time: String, file: String) {
        self.id = UUID()
        self.name = name
        self.time = time
        self.file = file
    }
    
    // Implement the hash(into:) method for Hashable conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // Implement the equals operator (==) for Hashable conformance
    static func == (lhs: Audio, rhs: Audio) -> Bool {
        lhs.id == rhs.id
    }

    var audioName: String {
        return name
    }
    
    var audioTime: String {
        return time
    }
    
    var audioFile: String {
        return file
    }
    
    var getAudioGroup: String {
            return "Default display group"
    }
}
