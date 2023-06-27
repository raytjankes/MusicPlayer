//
//  Music.swift
//  BCAMusicPlayer
//
//  Created by Ray on 26/06/23.
//

import Foundation

struct Music: Identifiable, Decodable {
    let id = UUID()
    let title: String
    let done: Bool
}
