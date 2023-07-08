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
    
    @Binding var debouncedText : String
    let debounceInterval = 0.5
    @State var timer: Timer?
    
    var body: some View {
        VStack{
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField(placeholder, text: $text)
                    .foregroundColor(.primary)
                    .onChange(of: text) { text in
                        debounceSearchText(text)
                    }
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
    
    func debounceSearchText(_ text: String) {
        timer?.invalidate() // This is what I forgot!!
        
        timer = Timer.scheduledTimer(withTimeInterval: debounceInterval, repeats: false) { _ in
            debouncedText = text
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    @State static var searchString = ""
    @State static var debounceString = ""
    
    static var previews: some View {
        SearchBarView(text: $searchString, placeholder: "Search..", debouncedText: $debounceString)
    }
}
