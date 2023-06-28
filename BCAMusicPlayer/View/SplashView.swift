//
//  SplashView.swift
//  BCAMusicPlayer
//
//  Created by Ray on 26/06/23.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        VStack {
            HStack{
                Image(systemName: "beats.headphones")
                    .resizable()
                    .padding()
                    .foregroundColor(Color.customHighlight)
            }
            .frame(width: 150,height: 150)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.customPrimary)
                    .shadow(radius: 10)
            )
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.customSecondary)
        .edgesIgnoringSafeArea(.all)
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
