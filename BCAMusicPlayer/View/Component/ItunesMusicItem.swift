//
//  ItunesMusicItem.swift
//  BCAMusicPlayer
//
//  Created by Ray on 08/07/23.
//

import SwiftUI

struct ItunesMusicItem: View {
    var music: ItunesMusic
    
    var body: some View {
        VStack {
            HStack {
                if let imageURL = URL(string: music.songImageURL) {
                    
                    // Set a default image
                    AsyncImage(url: imageURL) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        default:
                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(width: 50, height: 50)
                    .padding(2 )
                    .background(
                        Rectangle()
                            .foregroundColor(.customPrimary)
                    )
                    .padding(.trailing)
                }
                
                VStack(alignment: .leading) {
                    Text(music.audioName)
                    Text(music.getAudioGroup)
                        .foregroundColor(.customDisabledButton)
                }
                
                Spacer()
                
                Text(convertMillisecondsToMinutesSeconds(milliseconds: Int(music.audioTime) ?? 0))
            }
            
            Divider()
        }
        .padding(.horizontal)
        .onTapGesture {
            openExternalURL()
        }
    }
    
    // Convert the milisecond from JSON to minute:second
    func convertMillisecondsToMinutesSeconds(milliseconds: Int) -> String {
        let totalSeconds = milliseconds / 1000
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    // Redirect users to Apple Music since the API does not allow music Streaming
    func openExternalURL() {
        if let url = URL(string: music.audioFile) {
            UIApplication.shared.open(url, options: [:]) { success in
                if success {
                    print("Apple Music URL opened successfully")
                } else {
                    print("Failed to open Apple Music URL")
                }
            }
        }
    }
}


struct ItunesMusicItem_Previews: PreviewProvider {
    static var previews: some View {
        ItunesMusicItem(music: ItunesMusic(name: "dummy data", time: "dummy data", file: "dummy data", singer: "dummy data", imageURL: ""))
    }
}
