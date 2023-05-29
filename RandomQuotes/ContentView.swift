//
//  ContentView.swift
//  RandomQuotes
//
//  Created by Isaac Iniongun on 27/05/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = RandomImageListViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.randomImages) { randomImage in
                HStack(alignment: .top) {
                    randomImage.image.map {
                        Image(uiImage: $0)
                            .resizable()
                            .frame(width: 120, height: 120)
                            .aspectRatio(contentMode: .fit)
                    }
                    Text(randomImage.quote)
                }
            }
            .listStyle(.plain)
            .task {
                await viewModel.getRandomImages(ids: Array(10...50))
            }
            .navigationTitle("Random Quotes & Images")
            .navigationBarItems(trailing: Button(action: {
                Task {
                    await viewModel.getRandomImages(ids: Array(30...60))
                }
            }, label: {
                Image(systemName: "arrow.clockwise.circle")
            }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
