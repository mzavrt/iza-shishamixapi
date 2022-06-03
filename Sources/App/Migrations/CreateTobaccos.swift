//
//  File.swift
//  
//
//  Created by Matěj Zavrtálek on 30.05.2022.
//

import Fluent

struct CreateTobaccos: AsyncMigration{
    func prepare(on database: Database) async throws {
        
        let type = try await database.enum("types").read()
       
            try await database.schema("tobaccos")
                   .id()
                   .field("name",.string,.required)
                   .field("brand",.string,.required)
                   .field("type",type,.required)
                   .field("description",.string,.required)
                   .field("flavour",.string,.required)
                   .field("kind",.array(of: .string))
                   .field("imageUri",.string,.required)
                   .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("tobacoos").delete()
    }
        
    }
    
    
    
    

