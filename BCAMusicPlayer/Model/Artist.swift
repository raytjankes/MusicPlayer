//
//  Artist.swift
//  BCAMusicPlayer
//
//  Created by Ray on 27/06/23.
//

import Foundation

class Artist: Creator {
    private var songs: [Song]
    
    init(name: String, image: String, songs: [Song]) {
        self.songs = songs
        super.init(name: name, image: image)
    }
    
    override var getWorks: [Audio] {
        return songs.map { $0 as Audio }
    }
    
}
