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
            /*let randomImages = try await Webservice().getRandomImages(ids: ids)
            self.randomImages = randomImages.map(RandomImageViewModel.init)*/
            randomImages = []
            let webservice = Webservice()
            try await withThrowingTaskGroup(of: RandomImage.self, body: { group in
                for id in ids {
                    group.addTask {
                        try await webservice.getRandomImage(id: id)
                    }
                }
                
                for try await randomImage in group {
                    randomImages.append(RandomImageViewModel(randomImage: randomImage))
                }
            })
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
