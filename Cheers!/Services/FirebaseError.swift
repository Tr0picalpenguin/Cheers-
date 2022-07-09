//
//  FirebaseError.swift
//  Cheers!
//
//  Created by Scott Cox on 7/8/22.
//

import Foundation


enum FirebaseError: Error {
    case fireBaseError(Error)
    case failedToUnwrapData
    case noDataFound
}
