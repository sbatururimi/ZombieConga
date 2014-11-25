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
    let playableRect:CGRect
    
    override init(size: CGSize) {
        let maxAspectRatio:CGFloat = 16.0/9.0
        let playableHeight = size.width / maxAspectRatio
        let playableMargin =  (size.height - playableHeight) / 2.0
        playableRect = CGRect(x: 0, y: playableMargin, width: size.width, height: size.height)
        
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
//        moveSprite(zombie, velocity: CGPoint(x: zombieMovePointsPerSec, y: 0))
        moveSprite(zombie, velocity: velocity)
        
        boundsCheckZombie()
    }
    
    
    
    func moveSprite(sprite:SKSpriteNode, velocity: CGPoint)
    {
        let amountToMove = CGPoint(x:  velocity.x * CGFloat(dt), y: velocity.y * CGFloat(dt))
//        println("Amount to move: \(amountToMove)")
        
        sprite.position = CGPoint(x: sprite.position.x + amountToMove.x, y: sprite.position.y + amountToMove.y)
    }

    0.16/
    func moveZombieToward(location: CGPoint){
        let offset = CGPoint(x: location.x - zombie.position.x, y: location.y - zombie.position.y)
        let length = sqrt(Double(offset.x * offset.x + offset.y * offset.y))
        let direction = CGPoint(x: offset.x / CGFloat(length), y: offset.y / CGFloat(length))
        velocity = CGPoint(x: direction.x * zombieMovePointsPerSec, y: direction.y * zombieMovePointsPerSec)
    }
    
    func sceneTouched(touchLocation:CGPoint)
    {
        moveZombieToward(touchLocation)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        let touch = touches.anyObject() as UITouch
        let touchLocation = touch.locationInNode(self)
        sceneTouched(touchLocation)
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        let touch = touches.anyObject() as UITouch
        let touchLocation = touch.locationInNode(self)
        sceneTouched(touchLocation)
    }
    
    func boundsCheckZombie(){
        let bottomLeft = CGPointZero
        let topRight   = CGPoint(x: size.width, y: size.height)
        
        if zombie.position.x <= bottomLeft.x{
            zombie.position.x = bottomLeft.x
            velocity.x = -velocity.x
        }
        
        if zombie.position.x >= topRight.x
        {
            zombie.position.x = topRight.x
            velocity.x = -velocity.x
        }
        
        if zombie.position.y <= bottomLeft.y{
            zombie.position.y = bottomLeft.y
            velocity.y = -velocity.y
        }
        
        
        if zombie.position.y >= topRight.y{
            zombie.position.y = topRight.y
            velocity.y = -velocity.y
        }
    }
    
    
}
