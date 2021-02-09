//
//  ImageService.swift
//  PimpMyPlaylist
//
//  Created by Antoine THIEL on 09/02/2021.
//

import UIKit

class ImageService{
    
    public func getImage(from url: URL, completion: @escaping (UIImage?) -> Void) -> Void {
        let task = URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard err == nil, let d = data else {
                completion(nil)
                return
            }
            let image = UIImage(data: d)
            completion(image)
        }
        task.resume()
    }
}
