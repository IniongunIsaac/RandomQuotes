//
//  Webservice.swift
//  RandomQuotes
//
//  Created by Isaac Iniongun on 27/05/2023.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badDataFormat
    case unknown
}

class Webservice {
    
    func getRandomImages(ids: [Int]) async throws -> [RandomImage] {
        var randomImages = [RandomImage]()
        
        for id in ids {
            let randomImage = try await getRandomImage(id: id)
            randomImages.append(randomImage)
        }
        
        return randomImages
    }
    
    private func getRandomImage(id: Int) async throws -> RandomImage {
        guard let randomImageURL = Constants.Urls.randomImageURL else {
            throw NetworkError.badURL
        }
        
        guard let randomQuoteURL = Constants.Urls.randomQuoteURL else {
            throw NetworkError.badURL
        }
        
        async let (imageData, _) = URLSession.shared.data(from: randomImageURL)
        async let (quoteData, _) = URLSession.shared.data(from: randomQuoteURL)
        
        guard let randomQuote = try await quoteData.decode(into: Quote.self) else {
            throw NetworkError.badDataFormat
        }
        
        return RandomImage(image: try await imageData, quote: randomQuote)
    }
}

extension Data {
    func decode<T: Decodable>(into objectType: T.Type) throws -> T? {
        try JSONDecoder().decode(T.self, from: self)
    }
}
