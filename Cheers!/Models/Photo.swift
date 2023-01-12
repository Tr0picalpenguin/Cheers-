//
//  Photo.swift
//  Cheers!
//
//  Created by Scott Cox on 1/6/23.
//

import Foundation
import UIKit
import Firebase

class Photo {
    var image: UIImage
    var documentID: String
    var photoURL: String
    
    var dictionary: [String: Any] {
        return["photoURL":photoURL]
    }
    init(image: UIImage, documentID: String, photoURL: String) {
        self.image = image
        self.documentID = documentID
        self.photoURL = photoURL
    }
}

extension Photo {
    convenience init(documentID:String, photoURL: String) {
        self.init(image: UIImage(), documentID: documentID, photoURL: photoURL)
    }
    convenience init?(dictionary: [String:Any]) {
        guard let documentID = dictionary["documentID"] as? String,
              let photoURL = dictionary["photoURL"] as? String else {
            return nil
        }
        
        self.init(image: UIImage(), documentID: documentID, photoURL: photoURL)
    }
}

