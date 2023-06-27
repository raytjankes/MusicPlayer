//
//  Song.swift
//  BCAMusicPlayer
//
//  Created by Ray on 26/06/23.
//

import Foundation

struct Song:Hashable{
    var id = UUID()
    var name: String
    var time: String
    var file: String
}
