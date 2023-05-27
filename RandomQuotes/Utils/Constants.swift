//
//  Constants.swift
//  RandomQuotes
//
//  Created by Isaac Iniongun on 27/05/2023.
//

import Foundation

struct Constants {
    struct Urls {
        static let randomImageURL = URL(string: "https://picsum.photos/200/300?uuid=\(UUID().uuidString)")
        
        static let randomQuoteURL = URL(string: "https://api.quotable.io/random")
    }
}
