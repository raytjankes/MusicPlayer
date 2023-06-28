//
//  AudioItem.swift
//  BCAMusicPlayer
//
//  Created by Ray on 27/06/23.
//

import SwiftUI

struct AudioItem : View{
    var audio: Audio
    var body: some View {
            VStack{
                HStack{
                    ZStack{
                        Image(systemName: "opticaldisc.fill").resizable().frame(width: 30, height: 30, alignment: .center)
                            .foregroundColor(Color.customHighlight)
                            .padding(10)
                            .background(
                                Circle()
                                    .foregroundColor(Color.customPrimary)
                            )
                    }
                    .padding(.trailing)
                    
                    VStack(alignment: .leading){
                        
                        Text(audio.audioName)
                        Text(audio.getAudioGroup)
                            .foregroundColor(Color.customDisabledButton)
                    }
                    Spacer()
                    Text(audio.audioTime)
                }
                Divider()
            }.padding(.horizontal)
    }
}

struct AudioItem_Previews: PreviewProvider {
    static var previews: some View {
        AudioItem(audio: Song(name: "dummy data", time: "dummy data", file: "dummy data", artist: "dummy data"))
    }
}
