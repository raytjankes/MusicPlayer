//
//  Episode.swift
//  BCAMusicPlayer
//
//  Created by Ray on 27/06/23.
//

import Foundation

class Episode: Audio {
    private var podcast: String
    
    init(name: String, time: String, file: String, podcast: String) {
        self.podcast = podcast
        super.init(name: name, time: time, file: file)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    override var getAudioGroup: String {
            return podcast
    }
}
