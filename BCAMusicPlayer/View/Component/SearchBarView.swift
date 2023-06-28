//
//  SearchBarView.swift
//  BCAMusicPlayer
//
//  Created by Ray on 26/06/23.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    var placeholder: String

    var body: some View {
        VStack{
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField(placeholder, text: $text)
                    .foregroundColor(.primary)
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .opacity(text.isEmpty ? 0 : 1)
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal)
            .background(Color.customHighlight)
            .cornerRadius(10)
        }
        .padding()
        .background(Color.customPrimary)

    }
}

struct SearchBarView_Previews: PreviewProvider {
    @State static var searchString = ""
    
    static var previews: some View {
        SearchBarView(text: $searchString, placeholder: "Search..")
    }
}
