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
    /// MAIN MENU CONSTRUCTORS
    
    func AddMenuBackground()
    {
        self.m_menuBackground = SKSpriteNode(imageNamed: "BlackBackground")
        self.m_menuBackground.name = "blackBackground"
        self.m_menuBackground.size = CGSize(width: self.size.width, height: self.size.height)
        self.m_menuBackground.position = CGPoint(x: 0, y: 0)
        self.m_menuBackground.zPosition = 2
        self.addChild(self.m_menuBackground)
    }

    func AddMenuLogo()
    {
        //Reference Variables
        self.m_logo = SKSpriteNode(imageNamed: "ArkanoidLogo")
        self.m_logo.name = "LogoLabel"
        
        self.m_logo.size = CGSize(width: (2/3) * self.size.width, height: self.size.height/6)
        self.m_logo.position = CGPoint(x: 0, y: 350)
        self.m_logo.zPosition = 3
        self.addChild(self.m_logo)

    }

    func AddMenuPlayButton()
    {
        //Reference Variables
        self.m_playButtonLabel = SKLabelNode(text: "Play")
        self.m_playButtonLabel.name = "PlayButton"
        
        self.m_playButtonLabel.fontColor = UIColor.white
        self.m_playButtonLabel.fontSize = self.m_MenuLabelSize
    
        self.m_playButtonLabel.position = CGPoint(x: 0, y: 0)
        self.m_playButtonLabel.zPosition = 3
        self.addChild(self.m_playButtonLabel)
    }
    
    func AddMenuCreditsButton()
    {
        //Reference Variables
        self.m_creditsButtonLabel = SKLabelNode(text: "Credits")
        self.m_creditsButtonLabel.name = "CreditsButton"
        
        self.m_creditsButtonLabel.fontColor = UIColor.white
        self.m_creditsButtonLabel.fontSize = self.m_MenuLabelSize
    
        self.m_creditsButtonLabel.position = CGPoint(x: 0, y: -150)
        self.m_creditsButtonLabel.zPosition = 3
        self.addChild(self.m_creditsButtonLabel)
    }

    func AddMenuExitButton()
    {
        //Reference Variables
        self.m_exitButtonLabel = SKLabelNode(text: "Exit")
        self.m_exitButtonLabel.name = "ExitButton"
        
        self.m_exitButtonLabel.fontColor = UIColor.white
        self.m_exitButtonLabel.fontSize = self.m_MenuLabelSize
        self.m_exitButtonLabel.position = CGPoint(x: 0, y: -300)
        self.m_exitButtonLabel.zPosition = 3
        self.addChild(self.m_exitButtonLabel)
    }
    
    /// IN GAME CONSTRUCTORS
    
    func AddGameBackground()
    {
        self.m_gameBackground = SKSpriteNode(imageNamed: "Background")
        self.m_gameBackground.name = "gameBackground"
        self.m_gameBackground.size = CGSize(width: self.size.width, height: self.size.height)
        self.m_gameBackground.position = CGPoint(x: 0, y: 0)
        self.m_gameBackground.zPosition = 2
        self.addChild(self.m_gameBackground)
        
        //Hide it
        self.m_gameBackground.isHidden = true
    }
    
    func AddGameBar()
    {
        // Reference position
        self.m_Bar.position = CGPoint(x: 0, y: -300)
        self.m_Bar.zPosition = 3
        self.addChild(self.m_Bar)
        
        //Hide it
        self.m_Ball.isHidden = true
    }
    
    func AddGameBall()
    {
        // Reference position
        self.m_Ball.position = CGPoint(x: 0, y: -300)
        self.m_Ball.zPosition = 3
        self.addChild(self.m_Bar)
        
        //Hide it
        self.m_Ball.isHidden = true
    }
    
}
