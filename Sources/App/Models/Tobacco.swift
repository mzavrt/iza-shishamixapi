//
//  File.swift
//  
//
//  Created by Matěj Zavrtálek on 30.05.2022.
//

import Fluent
import Vapor
import Foundation

// String representable, Codable enum for tobacco types.
enum TobaccoType: String, Codable {
    case blonde, dark
}

final class Tobacco: Model, Content {
    static let schema = "tobaccos"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String
    
    @Field(key: "brand")
    var brand: String
    
    @Enum(key: "type")
    var type: TobaccoType
    
    @Field(key: "description")
    var description: String
    
    @Field(key: "flavour")
    var flavour: String
    
    @Field(key: "kind")
    var kind: [String]
    
    @Field(key: "imageUri")
    var imageUri: String
    
    @Siblings(through: UserTobaccoPivot.self, from: \.$tobacco, to: \.$user)
    public var users: [User]
    
    @Siblings(through: MixTobaccoPivot.self, from: \.$tobacco, to: \.$mix)
    public var mixes: [Mix]
   
    

    init() { }

    init(id: UUID? = nil, name: String, brand: String, type: TobaccoType, description:String, flavour: String, kind: [String], imageUri: String) {
        self.id = id
        self.name = name
        self.brand = brand
        self.type = type
        self.description = description
        self.flavour = flavour
        self.kind = kind
        self.imageUri = imageUri
    }
}
