//
//  File.swift
//  
//
//  Created by Matěj Zavrtálek on 30.05.2022.
//

import Vapor
import Fluent


struct CreateMixData: Content {
  let name: String
  let description: String
  let strenght: Int
  let userID: UUID
}

struct MixController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let mixes = routes.grouped("mixes")
        mixes.get(use: index)
        mixes.post(":mixID","tobaccos",":tobaccoID", use: addTobaccoToMix)
        mixes.post(use: createUsersMix)
        mixes.get(":userID",use: getUserMixes)
        mixes.delete(":mixID", use: deleteMixFromList)
        
       
        
        
        
    }
    
    // GET Request /tobaccos route
    func index(req: Request) throws -> EventLoopFuture<[Mix]> {
         Mix.query(on: req.db).all()
    }
    
    func addTobaccoToMix(req: Request) throws -> EventLoopFuture<Mix>
    {
        let userQuery =
        Mix.find(req.parameters.get("mixID"), on: req.db)
            .unwrap(or: Abort(.notFound))
        let tobaccoQuery =
        Tobacco.find(req.parameters.get("tobaccoID"), on: req.db)
            .unwrap(or: Abort(.notFound))
        
        return userQuery.and(tobaccoQuery)
            .flatMap { mix, tobacco in
                mix
                    .$containedTobaccos
                    .attach(tobacco, on: req.db)
                    .map{mix}
            }
    }
    
    func createUsersMix(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        
       
       let data = try req.content.decode(CreateMixData.self)
       let mix = Mix(name: data.name, description: data.description, strenght: data.strenght, userID: data.userID)
        return mix.save(on: req.db).transform(to: .ok)
    }
    
    func getUserMixes(req: Request) throws -> EventLoopFuture<[Mix]>{
        
        User.find(req.parameters.get("userID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { user in
              
              user.$ownedMixes.get(on: req.db)
            }
    }
    
    // DELETE Request /mixes/id route
    func deleteMixFromList(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        Mix.find(req.parameters.get("mixID"),on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap{$0.delete(on: req.db)}
            .transform(to: .ok)
    }
    
    
    
    
    
}
