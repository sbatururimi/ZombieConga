//
//  GameScene.swift
//  ZombieConga
//
//  Created by Virt on 19/11/14.
//  Copyright (c) 2014 @pp. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.whiteColor()
        let background = SKSpriteNode(imageNamed: "background1")
        addChild(background)
        
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
}
