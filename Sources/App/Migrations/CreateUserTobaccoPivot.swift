//
//  File.swift
//  
//
//  Created by Matěj Zavrtálek on 01.06.2022.
//

import Fluent


struct CreateUserTobaccoPivot: Migration {
  
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    
    database.schema("user-tobacco-pivot")
      
      .id()
      .field("userID", .uuid, .required,
        .references("users", "id", onDelete: .cascade))
      .field("tobaccoID", .uuid, .required,
        .references("tobaccos", "id", onDelete: .cascade))
      .unique(on: "userID", "tobaccoID")
      .create()
  }
  
  // 7
  func revert(on database: Database) -> EventLoopFuture<Void> {
    database.schema("user-tobacco-pivot").delete()
  }
}
