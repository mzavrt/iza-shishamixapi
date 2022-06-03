//
//  File.swift
//  
//
//  Created by Matěj Zavrtálek on 30.05.2022.
//

import Fluent
import Vapor
import Foundation


final class Mix: Model, Content {
    static let schema = "mixes"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String
        
    @Field(key: "description")
    var description: String
    
    @Field(key: "strenght")
    var strenght: Int
    
    @Parent(key: "userID")
    var user: User
    
    @Siblings(through: MixTobaccoPivot.self, from: \.$mix, to: \.$tobacco)
    public var containedTobaccos: [Tobacco]
    

    init() { }

    init(id: UUID? = nil, name: String, description: String, strenght:Int, userID: User.IDValue) {
        self.id = id
        self.name = name
        self.description = description
        self.strenght = strenght
        self.$user.id = userID
       
    }
}
