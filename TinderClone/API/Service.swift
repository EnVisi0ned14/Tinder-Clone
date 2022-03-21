//
//  Service.swift
//  TinderClone
//
//  Created by Michael Abrams on 3/19/22.
//

import Foundation
import Firebase

struct Service {
    
    static func uploadImage(image: UIImage, completion: @escaping (String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/images/\(filename)")
        
        ref.putData(imageData, metadata: nil) { _, error in
            guard error == nil else {
                print("DEBUG: Error uploading image \(error?.localizedDescription ?? "")")
                return
            }
            
            ref.downloadURL { url, error in
                guard let imageUrl = url?.absoluteString else { return }
                completion(imageUrl)
            }
            
        }
    }
    
}
