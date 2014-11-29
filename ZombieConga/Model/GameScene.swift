//
//  GameScene.swift
//  ZombieConga
//
//  Created by Virt on 19/11/14.
//  Copyright (c) 2014 @pp. All rights reserved.
//

import SpriteKit


class GameScene: SKScene {
    var lastTouchLocation: CGPoint?
    let zombie: SKSpriteNode = SKSpriteNode(imageNamed: "zombie1")
    var lastUpdateTime: NSTimeInterval = 0
    var dt: NSTimeInterval = 0
    let zombieMovePointsPerSec: CGFloat = 480.0
    var velocity = CGPointZero
    let playableRect:CGRect
    let zombieRotateRadianPerSec:CGFloat = 4.0 * π
    
    override init(size: CGSize) {
        let maxAspectRatio:CGFloat = 16.0/9.0
        let playableHeight = size.width / maxAspectRatio
        let playableMargin =  (size.height - playableHeight) / 2.0
        playableRect = CGRect(x: 0, y: playableMargin,
            width: size.width,
            height: playableHeight)
        
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func debugDrawPlayableArea()
    {
        let shape = SKShapeNode()
        let path = CGPathCreateMutable()
        CGPathAddRect(path, nil, playableRect)
        shape.path = path
        shape.strokeColor = SKColor.redColor()
        shape.lineWidth = 4.0
        addChild(shape)
    }
    
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.whiteColor()
        let background = SKSpriteNode(imageNamed: "background1")
        addChild(background)
        
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.zPosition = -1;
        /// zombie
        zombie.position = CGPoint(x: 400, y: 400)
        addChild(zombie)
        
        runAction(SKAction.repeatActionForever(
            SKAction.sequence([SKAction.runBlock(spawnEnemy),
                SKAction.waitForDuration(2.0)])))
//        spawnEnemy()
        debugDrawPlayableArea()
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
        
        
        if  let lastTouch = lastTouchLocation
        {
            var diff = lastTouch - zombie.position
            if (diff.length() <= zombieMovePointsPerSec * CGFloat(dt))
            {
                zombie.position = lastTouchLocation!
                velocity = CGPointZero
            }
            else
            {
                moveSprite(zombie, velocity: velocity)
                
                rotateSprite(zombie, direction: velocity, rotateRadianPerSec: zombieRotateRadianPerSec)
            }
        }
        
        boundsCheckZombie()
        
    }
    
    
    
    func moveSprite(sprite:SKSpriteNode, velocity: CGPoint)
    {
//        let amountToMove = CGPoint(x:  velocity.x * CGFloat(dt), y: velocity.y * CGFloat(dt))
//        sprite.position = CGPoint(x: sprite.position.x + amountToMove.x, y: sprite.position.y + amountToMove.y)
        let amountToMove = velocity * CGFloat(dt)
        sprite.position += amountToMove
        
    }

    func moveZombieToward(location: CGPoint){
//        let offset = CGPoint(x: location.x - zombie.position.x, y: location.y - zombie.position.y)
//        let length = sqrt(Double(offset.x * offset.x + offset.y * offset.y))
//        let direction = CGPoint(x: offset.x / CGFloat(length), y: offset.y / CGFloat(length))
//        velocity = CGPoint(x: direction.x * zombieMovePointsPerSec, y: direction.y * zombieMovePointsPerSec)
        let offset = location - zombie.position
        let direction = offset.normalized()
        velocity = direction * zombieMovePointsPerSec

    }
    
    func sceneTouched(touchLocation:CGPoint)
    {
        lastTouchLocation = touchLocation
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
//        let bottomLeft = CGPointZero
//        let topRight   = CGPoint(x: size.width, y: size.height)
        let bottomLeft = CGPoint(x: 0, y: CGRectGetMinY(playableRect))
        let topRight = CGPoint(x: size.width, y: CGRectGetMaxY(playableRect))
        
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
    
    
    func rotateSprite(sprite: SKSpriteNode, direction: CGPoint, rotateRadianPerSec: CGFloat)
    {
//        sprite.zRotation = CGFloat(atan2(Double(direction.y), Double(direction.x)))
        /// smoooth rotation
        let shortest = shortestAngleBetween(zombie.zRotation, velocity.angle())
        let amtToRotate = min(rotateRadianPerSec * CGFloat(dt), abs(shortest))
        sprite.zRotation += shortest.sign() * amtToRotate
    }
    
    
    func spawnEnemy(){
        let ennemy = SKSpriteNode(imageNamed: "enemy")
        ennemy.position = CGPoint(
            x: size.width + ennemy.size.width/2,
            y: CGFloat.random(
                min: CGRectGetMinY(playableRect) + ennemy.size.height/2,
                max: CGRectGetMaxY(playableRect) - ennemy.size.height/2))
        addChild(ennemy)

        
        let actionMove = SKAction.moveToX(-ennemy.size.width / 2, duration: 2.0)
        let actionRemove = SKAction.removeFromParent()
        ennemy.runAction(SKAction.sequence([actionMove, actionRemove]))
    }
}
