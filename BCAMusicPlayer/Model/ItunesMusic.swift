//
//  ItunesMusic.swift
//  BCAMusicPlayer
//
//  Created by Ray on 08/07/23.
//

import Foundation

class ItunesMusic: Audio {
    private var singer: String
    private var imageURL: String
    
    init(name: String, time: String, file: String, singer: String, imageURL: String) {
        self.singer = singer
        self.imageURL = imageURL
        super.init(name: name, time: time, file: file)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    var songImageURL: String {
        return imageURL
    }
    
    override var getAudioGroup: String {
        return singer
    }
}
