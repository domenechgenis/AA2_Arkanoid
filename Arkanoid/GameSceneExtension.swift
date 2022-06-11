//
//  GameSceneExtension.swift
//  Arkanoid
//
//  Created by Carla Carreras Maly on 11/6/22.
//

import Foundation
import SpriteKit

extension GameScene
{
    func addBlackBackground()
    {
        self.m_background = SKSpriteNode(imageNamed: "BlackBackground")
        self.m_background.name = "blackBackground"
        self.m_background.size = CGSize(width: self.size.width, height: self.size.height)
        self.m_background.position = CGPoint(x: 0, y: 0)
        self.m_background.zPosition = 2
        self.addChild(self.m_background)
    }

    func addLogo()
    {
        //Reference Variables
        self.m_logo = SKSpriteNode(imageNamed: "ArkanoidLogo")
        self.m_logo.name = "LogoLabel"
        
        self.m_logo.size = CGSize(width: (2/3) * self.size.width, height: self.size.height/6)
        self.m_logo.position = CGPoint(x: 0, y: 350)
        self.m_logo.zPosition = 3
        self.addChild(self.m_logo)

    }

    func addPlayButton()
    {
        //Reference Variables
        self.playButtonLabel = SKLabelNode(text: "Play")
        self.playButtonLabel.name = "PlayButton"
        
        self.playButtonLabel.fontColor = UIColor.white
        self.playButtonLabel.fontSize = self.m_MenuLabelSize
    
        self.playButtonLabel.position = CGPoint(x: 0, y: 0)
        self.playButtonLabel.zPosition = 3
        self.addChild(self.playButtonLabel)
    }
    
    func addOptionsButton()
    {
        //Reference Variables
        self.optionsButtonLabel = SKLabelNode(text: "Options")
        self.optionsButtonLabel.name = "OptionsButton"
        
        self.optionsButtonLabel.fontColor = UIColor.white
        self.optionsButtonLabel.fontSize = self.m_MenuLabelSize
    
        self.optionsButtonLabel.position = CGPoint(x: 0, y: -100)
        self.optionsButtonLabel.zPosition = 3
        self.addChild(self.optionsButtonLabel)
    }

    func addExitButton()
    {
        //Reference Variables
        self.exitButtonLabel = SKLabelNode(text: "Exit")
        self.exitButtonLabel.name = "ExitButton"
        
        self.exitButtonLabel.fontColor = UIColor.white
        self.exitButtonLabel.fontSize = self.m_MenuLabelSize
        self.exitButtonLabel.position = CGPoint(x: 0, y: -200)
        self.exitButtonLabel.zPosition = 3
        self.addChild(self.exitButtonLabel)
    }
}
