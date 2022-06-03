//
//  MixTobaccoPivot.swift
//  
//
//  Created by Matěj Zavrtálek on 02.06.2022.
//

import Fluent
import Vapor
import Foundation

final class MixTobaccoPivot: Model {
    static let schema = "mix-tobacco-pivot"

    @ID(key: .id)
    var id: UUID?

    @Parent(key: "userID")
    var mix: Mix

    @Parent(key: "tobaccoID")
    var tobacco: Tobacco

    init() { }

    init(id: UUID? = nil, mix: Mix, tobacco: Tobacco) throws {
        self.id = id
        self.$mix.id = try mix.requireID()
        self.$tobacco.id = try tobacco.requireID()
    }
}
