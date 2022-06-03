//
//  File.swift
//  
//
//  Created by Matěj Zavrtálek on 30.05.2022.
//

import Fluent

struct CreateTypes: AsyncMigration{
    func prepare(on database: Database) async throws{
        
        
    
    try await database.enum("types")
            .case("dark")
            .case("blonde")
            .case("mixed")
            .create()
     
     
    }
    
    func revert(on database: Database) async throws {
        try await database.enum("types").delete()
    }
    
    
}
