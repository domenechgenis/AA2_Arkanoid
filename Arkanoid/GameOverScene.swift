//
//  GameOverScene.swift
//  Arkanoid
//
//  Created by Carla Carreras Maly on 12/6/22.
//

import Foundation
import SpriteKit

class GameOverScene : SKScene
{
    //Game Variables
    //Constants
    let m_menuLabelSize : CGFloat = 80
    let m_GameBorderSize : CGFloat = 30
    
    //Menu Varables
    var m_GameOverlogo : SKSpriteNode!
    var m_GameOverplayButtonLabel: SKLabelNode!
    var m_GameOvercreditsButtonLabel: SKLabelNode!
    var m_GameOverexitButtonLabel: SKLabelNode!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let reveal = SKTransition.reveal(with: .down,duration: 1)
        let newScene = GameScene(size: CGSize(width: self.frame.width, height: self.frame.height))
        newScene.scaleMode = .aspectFill
        view?.presentScene(newScene,transition: reveal)
    }
    
    override func didMove(to view: SKView)
    {
        self.AddGameOverMenuLogo()
    }
}
