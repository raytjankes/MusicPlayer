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
        .padding(.horizontal, 16)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    @State static var searchString = ""
    
    static var previews: some View {
        SearchBarView(text: $searchString, placeholder: "Search..")
    }
}
