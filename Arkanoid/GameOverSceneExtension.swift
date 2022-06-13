//
//  GameOverSceneExtension.swift
//  Arkanoid
//
//  Created by Carla Carreras Maly on 12/6/22.
//

import Foundation
import SpriteKit

extension GameOverScene
{
    /// GAME  OVER MENU CONSTRUCTORS
    func AddGameOverMenuLogo()
    {
        //Reference Variables
        self.m_GameOverlogo = SKSpriteNode(imageNamed: "arkanoidLogo")
        self.m_GameOverlogo.name = "LogoLabel"
        
        self.m_GameOverlogo.size = CGSize(width: (2/3) * self.size.width, height: self.size.height/6)
        self.m_GameOverlogo.position = CGPoint(x: 0, y: 350)
        self.m_GameOverlogo.zPosition = 1
        
        self.addChild(self.m_GameOverlogo)
    }
}
