//
//  ReachabilityManager.swift
//  SimpleToDoList
//
//  Created by Mohamed Abdul-Hameed on 12/1/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import Reachability

final class ReachabilityManager: ReachabilityManagerType {
    
    static let shared = ReachabilityManager()
    
    private let reachability: Reachability
    
    private init(reachability: Reachability = Reachability()!) {
        self.reachability = reachability
    }
    
    func isReachable() -> Bool {
        return reachability.connection != .none
    }
}
