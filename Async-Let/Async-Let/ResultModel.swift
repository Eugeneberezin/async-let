//
//  JobsModel.swift
//  JobsModel
//
//  Created by Eugene Berezin on 7/22/21.
//

import Foundation

import Foundation

struct SearchResult: Decodable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Decodable, Identifiable {
   
    let trackId: Int
    let trackName: String
    let primaryGenreName: String
    var avarageUserrating: Float?
    let screenshotUrls: [String]
    let artworkUrl100: String // app icon
    
    var id: Int {
        return trackId
    }
}
