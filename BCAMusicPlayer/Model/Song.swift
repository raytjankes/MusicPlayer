//
//  Song.swift
//  BCAMusicPlayer
//
//  Created by Ray on 26/06/23.
//

import Foundation

class Song: Audio {
    private var artist: String
    
    init(name: String, time: String, file: String, artist: String) {
        self.artist = artist
        super.init(name: name, time: time, file: file)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    override var getAudioGroup: String {
            return artist
    }
}


