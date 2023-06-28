//
//  Podcast.swift
//  BCAMusicPlayer
//
//  Created by Ray on 27/06/23.
//

import Foundation

class Podcast: Creator {
    private var episodes: [Episode]
    
    init(name: String, image: String, episodes: [Episode]) {
        self.episodes = episodes
        super.init(name: name, image: image)
    }
    
    override var getWorks: [Audio] {
        return episodes.map { $0 as Audio }
    }
}
