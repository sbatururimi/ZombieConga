//
//  MainMenuScene.swift
//  ZombieConga
//
//  Created by Virt on 31/01/15.
//  Copyright (c) 2015 @pp. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenuScene:SKScene {
     override func  didMoveToView(view: SKView) {
        let background:SKSpriteNode = SKSpriteNode(imageNamed: "MainMenu.png")
        background.position = CGPoint(x: self.size.width / 2.0, y: self.size.height / 2.0)
        self.addChild(background)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        sceneTapped();
    }
    
    func sceneTapped(){
        let scene = GameScene(size: size)
        let reveal = SKTransition.doorwayWithDuration(0.5)
        view?.presentScene(scene, transition: reveal)
    }
}
