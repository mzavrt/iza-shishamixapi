//
//  File.swift
//  
//
//  Created by Matěj Zavrtálek on 30.05.2022.
//

import Fluent

struct CreateMixes: AsyncMigration{
    func prepare(on database: Database) async throws{
        
       
        let type = try await database.enum("types").read()

        
        try await database.schema("mixes")
            .id()
            .field("name",.string,.required)
            .field("description",.string,.required)
            .field("strenght",.int,.required)
            .field("userID", .uuid, .required, .references("users", "id"))
            .create()
         
        
           
        
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("mixes").delete()
    }
    
    
}
