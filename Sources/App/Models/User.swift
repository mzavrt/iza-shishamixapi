//
//  File.swift
//  
//
//  Created by Matěj Zavrtálek on 30.05.2022.
//

import Fluent
import Vapor
import Foundation


final class User: Model, Content {
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "userName")
    var userName: String
    
    @Children(for: \.$user)
    var ownedMixes: [Mix]
        
    @Siblings(through: UserTobaccoPivot.self, from: \.$user, to: \.$tobacco)
    public var ownedTobaccos: [Tobacco]
    
    init() { }

    init(id: UUID? = nil, userName: String) {
        self.id = id
        self.userName = userName
       
       
    }
}

