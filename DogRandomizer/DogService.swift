//
//  DogService.swift
//  DogRandomizer
//
//  Created by Vanda S. on 01/07/2022.
//

import Foundation
import UIKit

var dogImage: UIImage?

struct Dog: Codable {
    var message: String
}

func fetchDog(completion: @escaping (UIImage) -> ()) {
    var dogImage: UIImage?
    let url = URL(string: "https://dog.ceo/api/breeds/image/random")
    guard let url = url else {
        return
    }
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        guard let dog = try? JSONDecoder().decode(Dog.self, from: data) else {
            return
        }
        guard let decodedDogUrl = URL(string: dog.message) else {
            return
        }
        guard let imageData = try? Data(contentsOf: decodedDogUrl) else {
            return
        }
        
        dogImage = UIImage(data: imageData)
        completion(dogImage!)
    }.resume()
    
    
}
