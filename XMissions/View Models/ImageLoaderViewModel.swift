//
//  ImageLoader.swift
//  XMissions
//
//  Created by Hossein Akbari on 2/21/1400 AP.
//

import SwiftUI

class ImageLoaderViewModel: ObservableObject {
    @Published var downloadedImage: Data?
    
    func downloadImage(url: String) {
        guard let url = URL(string: url) else {
            fatalError("Image URL is not correct")
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self.downloadedImage = data
            }
        }.resume()
    }
}
