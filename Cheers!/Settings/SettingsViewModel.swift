//
//  SettingsViewModel.swift
//  Cheers!
//
//  Created by Scott Cox on 9/12/22.
//

import Foundation

class SettingsViewModel {
    
    
    private var service: FirebaseSyncable
    
    init(service: FirebaseSyncable = FirebaseService()) {
        self.service = service
    }
    
    func logout() {
        service.logoutUser()
        UserDefaults.standard.removeObject(forKey: "email")
        
    }
    
    func deleteUser() {
        service.deleteUser()
    }
}
