//
//  File.swift
//  
//
//  Created by Matěj Zavrtálek on 30.05.2022.
//

import Foundation

import Vapor
import Fluent

struct TobaccoController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let tobaccos = routes.grouped("tobaccos")
        tobaccos.get(use: index)
        tobaccos.post(use: create)
        
        tobaccos.group(":id"){
            tobacco in tobacco.get(use: getRequestedTobaccos)
        }
    }
    
    // GET Request /tobaccos route
    func index(req: Request) throws -> EventLoopFuture<[Tobacco]> {
        return Tobacco.query(on: req.db).all()
    }
    
    func getRequestedTobaccos(req: Request) throws -> EventLoopFuture<Tobacco> {
        
        return Tobacco.find(req.parameters.get("id"), on: req.db)
               .unwrap(or: Abort(.notFound))
            
    }
    
    
    // POST Request /tobaccos route
    func create(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let tobacco = try req.content.decode(Tobacco.self)
        return tobacco.save(on: req.db).transform(to: .ok)
    }
    
}

