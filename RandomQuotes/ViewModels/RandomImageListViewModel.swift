//
//  RandomImageListViewModel.swift
//  RandomQuotes
//
//  Created by Isaac Iniongun on 29/05/2023.
//

import Foundation
import UIKit

@MainActor
class RandomImageListViewModel: ObservableObject {
    @Published var randomImages: [RandomImageViewModel] = []
    
    func getRandomImages(ids: [Int]) async {
        do {
            let randomImages = try await Webservice().getRandomImages(ids: ids)
            self.randomImages = randomImages.map(RandomImageViewModel.init)
        } catch {
            print(error)
        }
    }
}

struct RandomImageViewModel: Identifiable {
    fileprivate let randomImage: RandomImage
    
    let id = UUID()
    
    var image: UIImage? {
        UIImage(data: randomImage.image)
    }
    
    var quote: String {
        randomImage.quote.content
    }
}
