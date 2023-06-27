//
//  Album.swift
//  BCAMusicPlayer
//
//  Created by Ray on 26/06/23.
//

import Foundation

struct Album: Hashable {
    var id = UUID()
    var name: String
    var image: String
    var songs : [Song]
}
