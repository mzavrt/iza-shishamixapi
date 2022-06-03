//
//  CreateMixTobaccoPivot.swift
//  
//
//  Created by Matěj Zavrtálek on 02.06.2022.
//

import Fluent


struct CreateMixTobaccoPivot: Migration {
  
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    
    database.schema("mix-tobacco-pivot")
      
      .id()
      .field("mixID", .uuid, .required,
        .references("mixes", "id", onDelete: .cascade))
      .field("tobaccoID", .uuid, .required,
        .references("tobaccos", "id", onDelete: .cascade))
      .unique(on: "mixID", "tobaccoID")
      .create()
  }
  
  // 7
  func revert(on database: Database) -> EventLoopFuture<Void> {
    database.schema("mix-tobacco-pivot").delete()
  }
}

