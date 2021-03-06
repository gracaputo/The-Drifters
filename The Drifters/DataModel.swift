//
//  DataModel.swift
//  The Drifters
//
//  Created by Graziella Caputo on 17/02/2018.
//  Copyright © 2018 Graziella Caputo. All rights reserved.
//

import Foundation

final class DataModel {
    static let shared = DataModel()
    
    private let userDefaults = UserDefaults.standard
    
//    originView true -> Garden, false -> wishList
    var originView: Bool = true
    
    var isFirstTimeCamera: Bool {
        return userDefaults.bool(forKey: "Camera")
    }
    
    // *** CHECK VARIABLE FOR FIRST ACCESS
    var isFirstTime: Bool {
        return userDefaults.bool(forKey: "Onboarding")
    }
    
    private init(){
        userDefaults.register(defaults: ["Onboarding" : true])
        userDefaults.register(defaults: ["Camera" : true])
    }
    
    
    
    
}
