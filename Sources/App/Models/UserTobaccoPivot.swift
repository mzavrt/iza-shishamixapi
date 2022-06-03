//
//  UserTobaccoPivot.swift
//  
//
//  Created by Matěj Zavrtálek on 01.06.2022.
//


import Fluent
import Vapor
import Foundation

final class UserTobaccoPivot: Model {
    static let schema = "user-tobacco-pivot"

    @ID(key: .id)
    var id: UUID?

    @Parent(key: "userID")
    var user: User

    @Parent(key: "tobaccoID")
    var tobacco: Tobacco

    init() { }

    init(id: UUID? = nil, user: User, tobacco: Tobacco) throws {
        self.id = id
        self.$user.id = try user.requireID()
        self.$tobacco.id = try tobacco.requireID()
    }
}
