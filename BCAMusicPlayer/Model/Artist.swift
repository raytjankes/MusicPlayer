//
//  Artist.swift
//  BCAMusicPlayer
//
//  Created by Ray on 27/06/23.
//

import Foundation

struct Artist: Hashable {
    var id = UUID()
    var name: String
    var image: String
    var songs : [Song]
}
