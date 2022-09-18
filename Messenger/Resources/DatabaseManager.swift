//
//  DatabaseManager.swift
//  Messenger
//
//  Created by Ya on 18.09.22.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
}

// MARK: - Account Management

struct ChatAppUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
//    let profilePicteruUrl: String
}

extension DatabaseManager {
    
    public func userExists(with email: String, completion: @escaping ((Bool) -> Void)) {
        
        database.child(email).observeSingleEvent(of: .value) { snapshot in
            guard let _ = snapshot.value as? String else {
                completion(false)
                return
            }
            
            completion(true)
        }
        
    }
    
    ///Inserts new user to database
    public func insertUser(with user: ChatAppUser) {
        database.child(user.emailAddress).setValue(([
            "first_name": user.firstName,
            "last_name": user.lastName
        ]))
    }
}
