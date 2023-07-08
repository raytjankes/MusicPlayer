//
//  ItunesMusicServices.swift
//  BCAMusicPlayer
//
//  Created by Ray on 08/07/23.
//

import Foundation

// Using protocol for a more loose coupling programming
protocol iTunesMusicServices {
    func searchMusic(withTerm term: String, completion: @escaping (Result<[ItunesMusic], Error>) -> Void)
}

class iTunesMusicAPI: iTunesMusicServices {
    
    func searchMusic(withTerm term: String, completion: @escaping (Result<[ItunesMusic], Error>) -> Void) {
        let searchTerm = term.replacingOccurrences(of: " ", with: "+")
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=song"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response.self, from: data)
                
                let songs = response.results.map { music in
                    ItunesMusic(name: music.trackName, time: String(music.trackTimeMillis), file: music.trackViewUrl, singer: music.artistName, imageURL: music.artworkUrl100 )
                }
                
                completion(.success(songs))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}

// Specifying our struct to be the recieving blueprint
struct Response: Codable {
    let results: [Music]
}

// Needs precise naming for key value from jscript to enter this struct
struct Music: Codable {
    let trackName: String
    let artistName: String
    let trackTimeMillis: Int
    let trackViewUrl: String
    let artworkUrl100: String
}
