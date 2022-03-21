//
//  AuthService.swift
//  TinderClone
//
//  Created by Michael Abrams on 3/19/22.
//

import UIKit
import Firebase


struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let profileImage: UIImage
}

struct AuthService {
    
    static func logUserIn(withEmail email: String, password: String,
                          completion: AuthDataResultCallback?) {
        
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
        
    }
    
    static func registerUser(withCredentials credentials: AuthCredentials,
                             completion: @escaping ((Error?) -> Void)) {
        
        Service.uploadImage(image: credentials.profileImage) { imageUrl in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
                
                guard error == nil else {
                    print("DEBUG: Error signing user up \(error?.localizedDescription ?? "")")
                    return
                }
                
                guard let uid = result?.user.uid else { return }
                
                let data: [String: Any] = ["email": credentials.email,
                            "fullname": credentials.fullname,
                            "imageUrl": imageUrl,
                            "uid": uid,
                            "age": 18]
                
                Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
                
            }
        }
        
    }
}
