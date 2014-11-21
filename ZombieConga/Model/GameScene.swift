//
//  GameScene.swift
//  ZombieConga
//
//  Created by Virt on 19/11/14.
//  Copyright (c) 2014 @pp. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let zombie: SKSpriteNode = SKSpriteNode(imageNamed: "zombie1")
    var lastUpdateTime: NSTimeInterval = 0
    var dt: NSTimeInterval = 0
    let zombieMovePointsPerSec: CGFloat = 480.0
    var velocity = CGPointZero
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.whiteColor()
        let background = SKSpriteNode(imageNamed: "background1")
        addChild(background)
        
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        /// zombie
        zombie.position = CGPoint(x: 400, y: 400)
//        zombie.setScale(2.0)
        addChild(zombie)
        
    }
    
    override func update(currentTime: NSTimeInterval) {
        if lastUpdateTime > 0
        {
            dt = currentTime - lastUpdateTime
        }
        else
        {
            dt = 0
        }
        lastUpdateTime = currentTime
//        println("\(dt * 1000) milliseconds since last update")
//        zombie.position = CGPoint (x: zombie.position.x + 4, y: zombie.position.y)
        moveSprite(zombie, velocity: CGPoint(x: zombieMovePointsPerSec, y: 0))
    }
    
    
    
    func moveSprite(sprite:SKSpriteNode, velocity: CGPoint)
    {
        let amountToMove = CGPoint(x:  velocity.x * CGFloat(dt), y: velocity.y * CGFloat(dt))
        println("Amount to move: \(amountToMove)")
        
        sprite.position = CGPoint(x: sprite.position.x + amountToMove.x, y: sprite.position.y + amountToMove.y)
    }
}
