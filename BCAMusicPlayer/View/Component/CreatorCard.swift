//
//  CreatorCard.swift
//  BCAMusicPlayer
//
//  Created by Ray on 27/06/23.
//

import SwiftUI

struct CreatorCard:View{
    @EnvironmentObject var creatorVM: CreatorViewModel
    var creator :Creator
    var isPlayer: Bool
    var body: some View {
        ZStack{
            Image(uiImage: creator.creatorImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)

        }
        .frame(width: !isPlayer ? 170 : 270, height: !isPlayer ? 200 : 270, alignment: .center)
        .clipped()
        .cornerRadius(40)
        .shadow(radius: 10)
        .padding(10)
    }
}

struct CreatorCard_Previews: PreviewProvider {
    static var previews: some View {
        CreatorCard(creator: Artist(name: "dummy", image: UIImage(named:"trial-image")!, songs: [Song(name: "dummy data", time: "dummy data", file: "dummy data", artist: "dummy data")]), isPlayer: true)
            .environmentObject(CreatorViewModel())
    }
}
