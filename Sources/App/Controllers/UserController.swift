//
//  File.swift
//  
//
//  Created by Matěj Zavrtálek on 31.05.2022.
//

import Foundation

import Vapor
import Fluent

struct UserController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let users = routes.grouped("users")
        users.post(use:create)
        users.post( ":userID",
                    "tobaccos",
                    ":tobaccoID", use: addTobaccoToList)
        users.get(":userID","tobaccos",use: getUserTobaccos)
        
        users.get(use:index)
        users.get("find",":userName",use: getUserWithUserName)
        users.get("findID",":userID",use: getUserWithID )
        users.delete(":userID","tobaccos",":tobaccoID", use: deleteTobaccoFromList )
        
        
        
        
        
    }
    
    // GET User Request /users route
    func getUserWithUserName(req: Request) throws -> EventLoopFuture<User> {
        
        guard
            let userName = req.parameters.get("userName")
                
        else { throw Abort(.badRequest) }
        
        
        return User.query(on: req.db).filter(\.$userName == userName).first()
            .unwrap(or: Abort(.notFound))
        
    }
    
    func getUserWithID(req: Request) throws -> EventLoopFuture<User> {
        
        return User.find(req.parameters.get("userID"), on: req.db).unwrap(or: Abort(.notFound))
        
    }
    
    // GET ALL Request /user route
    func index(req: Request) throws -> EventLoopFuture<[User]> {
        return User.query(on: req.db).all()
    }
    
    // POST Request /users route
    func create(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let user = try req.content.decode(User.self)
        return user.save(on: req.db).transform(to: .ok)
    }
    
    // POST Request /users/:userID/tobaccos/:tobaccoID
    func addTobaccoToList(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let userQuery =
        User.find(req.parameters.get("userID"), on: req.db)
            .unwrap(or: Abort(.notFound))
        let tobaccoQuery =
        Tobacco.find(req.parameters.get("tobaccoID"), on: req.db)
            .unwrap(or: Abort(.notFound))
        
        return userQuery.and(tobaccoQuery)
            .flatMap { user, tobacco in
                user
                    .$ownedTobaccos
                
                    .attach(tobacco, on: req.db)
                    .transform(to: .ok)
            }
    }
    
    func getUserTobaccos(req: Request) throws -> EventLoopFuture<[Tobacco]>
    {
      return User.find(req.parameters.get("userID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { user in
                // 3
                 user.$ownedTobaccos.query(on: req.db).all()
            }
        
        
    }
    
    func deleteTobaccoFromList(req: Request) throws -> EventLoopFuture<HTTPStatus>
    {
        let userQuery =
        User.find(req.parameters.get("userID"), on: req.db)
            .unwrap(or: Abort(.notFound))
        let tobaccoQuery =
        Tobacco.find(req.parameters.get("tobaccoID"), on: req.db)
            .unwrap(or: Abort(.notFound))
        
        return userQuery.and(tobaccoQuery)
            .flatMap { user, tobacco in
                user
                    .$ownedTobaccos
                    .detach(tobacco, on: req.db)
                    .transform(to: .ok)
            }
    }
    
    
    
}
