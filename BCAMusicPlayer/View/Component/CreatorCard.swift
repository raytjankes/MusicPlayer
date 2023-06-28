//
//  CreatorCard.swift
//  BCAMusicPlayer
//
//  Created by Ray on 27/06/23.
//

import SwiftUI

struct CreatorCard:View{
    var creator :Creator
    var isWithText: Bool
    var body: some View {
        ZStack{
            Image(creator.creatorImage)
                .resizable()
            
            if isWithText == true{
                ZStack{
                    Text(creator.creatorName).foregroundColor(.white)
                }
            }

        }
        .frame(width: 170, height: 200, alignment: .center)
        .clipped()
        .cornerRadius(40)
        .shadow(radius: 10)
        .padding(10)
    }
}

struct CreatorCard_Previews: PreviewProvider {
    static var previews: some View {
        CreatorCard(creator: Artist(name: "dummy", image: "trial-image", songs: [Song(name: "dummy data", time: "dummy data", file: "dummy data", artist: "dummy data")]), isWithText: true)
    }
}
