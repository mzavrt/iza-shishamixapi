//
//  File.swift
//  
//
//  Created by Matěj Zavrtálek on 30.05.2022.
//


import Fluent

struct CreateUsers: AsyncMigration{
    func prepare(on database: Database) async throws{
    
    
    
    try await database.schema("users")
            .id()
            .field("userName",.string,.required)
            .unique(on: "userName")
            .create()
     
    
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("users").delete()
    }
    
        
    
}
        
   
    
    

