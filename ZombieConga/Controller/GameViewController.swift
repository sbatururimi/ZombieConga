//
//  GameViewController.swift
//  ZombieConga
//
//  Created by Virt on 19/11/14.
//  Copyright (c) 2014 @pp. All rights reserved.
//

import UIKit
import SpriteKit



class GameViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
//        let scene = GameScene(size:CGSize(width: 2048, height: 1536))
        let scene = MainMenuScene(size: CGSize(width: 2048, height : 1536))
        let skView = self.view as SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .AspectFill
        skView.presentScene(scene)
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
