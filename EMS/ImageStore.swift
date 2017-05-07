//
//  ImageStore.swift
//  EMS
//
//  Created by Hanuman on 07/05/17.
//  Copyright © 2017 Hanuman. All rights reserved.
//

import UIKit

class ImageStore {
    
    let cache = NSCache<AnyObject, AnyObject>()
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as AnyObject)
        
        let imageURL = imageURLForKey(key)
        
        //TODO: always a jpeg even when adding photos manually?
        if let data = UIImageJPEGRepresentation(image, 0.5) {
            try? data.write(to: imageURL, options: [.atomic])
        }
    }
    
    func imageForKey(_ key: String) -> UIImage? {
        if let existingImage = cache.object(forKey: key as AnyObject) as? UIImage {
            return existingImage
        }
        
        let imageURL = imageURLForKey(key)
        
        guard let imageFromDisk = UIImage(contentsOfFile: imageURL.path) else {
            return nil
        }
        
        cache.setObject(imageFromDisk, forKey: key as AnyObject)
        
        return imageFromDisk
    }
    
    func deleteImageForKey(_ key: String) {
        cache.removeObject(forKey: key as AnyObject)
        
        let imageURL = imageURLForKey(key)
        do {
            try FileManager.default.removeItem(at: imageURL)
        } catch {
            print("Error removing images from disk: \(error)")
        }
    }
    
    func imageURLForKey(_ key: String) -> URL {
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentDirectories.first!
        
        return documentDirectory.appendingPathComponent(key)
    }
}
