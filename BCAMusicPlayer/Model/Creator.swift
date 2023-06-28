//
//  Creator.swift
//  BCAMusicPlayer
//
//  Created by Ray on 27/06/23.
//

import Foundation

class Creator : Hashable {
    private var id: UUID
    private var name: String
    private var image: String
    
    init(name: String, image: String) {
        self.id = UUID()
        self.name = name
        self.image = image
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Creator, rhs: Creator) -> Bool {
        lhs.id == rhs.id
    }

    var getWorks: [Audio] {
            return [Audio(name: "dummy_data", time: "dummy_data", file: "dummy_data")]
    }
    
    var creatorName: String {
        return name
    }
    
    var creatorImage: String {
        return image
    }
}
