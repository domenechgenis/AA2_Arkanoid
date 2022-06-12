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
    var m_menuBackground : SKSpriteNode!
    var m_logo : SKSpriteNode!
    var m_playButtonLabel: SKLabelNode!
    var m_creditsButtonLabel: SKLabelNode!
    var m_exitButtonLabel: SKLabelNode!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        let scene : SKScene = GameScene(size: self.frame.size)
        scene.scaleMode = .aspectFit
        self.view?.presentScene(scene,transition: transition)
    }
}
