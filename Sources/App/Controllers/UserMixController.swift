//
//  File.swift
//  
//
//  Created by Matěj Zavrtálek on 02.06.2022.
//

import Foundation

import Vapor
import Fluent


struct UserMixController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let users = routes.grouped("users")
        
    }
    
    
}
