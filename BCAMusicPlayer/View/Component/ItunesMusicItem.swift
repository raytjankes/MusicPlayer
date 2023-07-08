//
//  ItunesMusicItem.swift
//  BCAMusicPlayer
//
//  Created by Ray on 08/07/23.
//

import SwiftUI

struct ItunesMusicItem: View {
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
                    Text(convertMillisecondsToMinutesSeconds(milliseconds: Int(audio.audioTime) ?? 0))
                }
                Divider()
            }
            .padding(.horizontal)
            .onTapGesture {
                openExternalURL()
            }
    }
    
    func convertMillisecondsToMinutesSeconds(milliseconds: Int) -> String {
        let totalSeconds = milliseconds / 1000
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func openExternalURL() {
        UIApplication.shared.open(URL(string: audio.audioFile)!, options: [:]) { success in
                if success {
                    print("Apple Music URL opened successfully")
                } else {
                    print("Failed to open Apple Music URL")
                }
            }
        }
}

struct ItunesMusicItem_Previews: PreviewProvider {
    static var previews: some View {
        ItunesMusicItem(audio: Song(name: "dummy data", time: "dummy data", file: "dummy data", artist: "dummy data"))
    }
}
