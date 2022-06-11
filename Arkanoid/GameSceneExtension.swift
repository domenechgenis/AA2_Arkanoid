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
        // Reference Variables
        self.m_menuBackground = SKSpriteNode(imageNamed: "blackbackground")
        self.m_menuBackground.name = "blackbackground"
        
        self.m_menuBackground.size = CGSize(width: self.size.width, height: self.size.height)
        self.m_menuBackground.position = CGPoint(x: 0, y: 0)
        self.m_menuBackground.zPosition = 0
        self.addChild(self.m_menuBackground)
    }

    func AddMenuLogo()
    {
        //Reference Variables
        self.m_logo = SKSpriteNode(imageNamed: "arkanoidLogo")
        self.m_logo.name = "LogoLabel"
        
        self.m_logo.size = CGSize(width: (2/3) * self.size.width, height: self.size.height/6)
        self.m_logo.position = CGPoint(x: 0, y: 350)
        self.m_logo.zPosition = 1
        self.addChild(self.m_logo)

    }

    func AddMenuPlayButton()
    {
        //Reference Variables
        self.m_playButtonLabel = SKLabelNode(text: "Play")
        self.m_playButtonLabel.name = "PlayButton"
        
        self.m_playButtonLabel.fontColor = UIColor.white
        self.m_playButtonLabel.fontSize = self.m_menuLabelSize
    
        self.m_playButtonLabel.position = CGPoint(x: 0, y: 0)
        self.m_playButtonLabel.zPosition = 1
        self.addChild(self.m_playButtonLabel)
    }
    
    func AddMenuCreditsButton()
    {
        //Reference Variables
        self.m_creditsButtonLabel = SKLabelNode(text: "Credits")
        self.m_creditsButtonLabel.name = "CreditsButton"
        
        self.m_creditsButtonLabel.fontColor = UIColor.white
        self.m_creditsButtonLabel.fontSize = self.m_menuLabelSize
    
        self.m_creditsButtonLabel.position = CGPoint(x: 0, y: -150)
        self.m_creditsButtonLabel.zPosition = 1
        self.addChild(self.m_creditsButtonLabel)
    }

    func AddMenuExitButton()
    {
        //Reference Variables
        self.m_exitButtonLabel = SKLabelNode(text: "Exit")
        self.m_exitButtonLabel.name = "ExitButton"
        
        self.m_exitButtonLabel.fontColor = UIColor.white
        self.m_exitButtonLabel.fontSize = self.m_menuLabelSize
        self.m_exitButtonLabel.position = CGPoint(x: 0, y: -300)
        self.m_exitButtonLabel.zPosition = 1
        self.addChild(self.m_exitButtonLabel)
    }
    
    /// IN GAME CONSTRUCTORS
    
    func AddGameBackground()
    {
        self.m_gameBackground = SKSpriteNode(imageNamed: "hexagon_pattern")
        self.m_gameBackground.name = "gameBackground"
        self.m_gameBackground.size = CGSize(width: self.size.width, height: self.size.height)
        self.m_gameBackground.position = CGPoint(x: 0, y: 0)
        self.m_gameBackground.zPosition = 0
        self.addChild(self.m_gameBackground)
        
        //Hide it
        self.m_gameBackground.isHidden = true
    }
    
    func AddBorders()
    {
        // Top
        self.m_borderTop = SKSpriteNode(imageNamed: "border_top")
        self.m_borderTop.name = "borderTop"
        self.m_borderTop.size = CGSize(width: self.size.width, height: m_GameBorderSize)
        self.m_borderTop.position = CGPoint(x: 0, y: self.size.height / 2)
        self.m_borderTop.zPosition = 1
        self.addChild(self.m_borderTop)
        
        // Left
        self.m_borderLeft = SKSpriteNode(imageNamed: "border_left")
        self.m_borderLeft.name = "borderLeft"
        self.m_borderLeft.size = CGSize(width: m_GameBorderSize, height: self.size.height)
        self.m_borderLeft.position = CGPoint(x: -(self.size.width / 2), y: 0)
        self.m_borderLeft.zPosition = 1
        self.addChild(self.m_borderLeft)
        
        // Right
        self.m_borderRight = SKSpriteNode(imageNamed: "border_right")
        self.m_borderRight.name = "borderRight"
        self.m_borderRight.size = CGSize(width: m_GameBorderSize, height: self.size.height)
        self.m_borderRight.position = CGPoint(x: (self.size.width / 2), y: 0)
        self.m_borderRight.zPosition = 1
        self.addChild(self.m_borderRight)
        
        //Set Physics
        AddStaticPhysics(_sprite: self.m_borderTop)
        AddStaticPhysics(_sprite: self.m_borderLeft)
        AddStaticPhysics(_sprite: self.m_borderRight)
        
        //Hide it
        self.m_borderLeft.isHidden = true
        self.m_borderRight.isHidden = true
        self.m_borderTop.isHidden = true
    }
    
    func AddGameBar()
    {
        self.m_Bar = SKSpriteNode(imageNamed: "racket")
        self.m_Bar.name = "bar"
        self.m_Bar.size = CGSize(width: m_Bar.size.width * 3, height: m_Bar.size.height * 3)
        self.m_Bar.position = CGPoint(x: 0, y: -(self.size.height / 2) + 100)
        self.m_Bar.zPosition = 2
        self.addChild(self.m_Bar)
        
        //Hide it
        self.m_Bar.isHidden = true
    }
    
    func AddGameBall()
    {
        self.m_Ball = SKSpriteNode(imageNamed: "ball")
        self.m_Ball.name = "ball"
        self.m_Ball.size = CGSize(width: m_Ball.size.width * 4, height: m_Ball.size.height * 4)
        self.m_Ball.position = CGPoint(x: 0, y: 0)
        self.m_Ball.zPosition = 2
        self.addChild(self.m_Ball)
        
        // Physics
        self.m_Ball.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height))
        self.m_Ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        self.m_Ball.physicsBody?.affectedByGravity = false
        self.m_Ball.physicsBody?.allowsRotation = false
        self.m_Ball.physicsBody?.restitution = 1.0
        self.m_Ball.physicsBody?.friction = 0.0
        self.m_Ball.physicsBody?.linearDamping = 0.0
        
        // Collision
        self.m_Ball.physicsBody?.collisionBitMask = self.m_collisionBitmask
        
        //Hide it
        self.m_Ball.isHidden = true
    }
    
    private func AddStaticPhysics(_sprite : SKSpriteNode)
    {
        _sprite.physicsBody = SKPhysicsBody(texture: _sprite.texture!, size: _sprite.size)
        
        _sprite.physicsBody?.allowsRotation = false
        _sprite.physicsBody?.affectedByGravity = false
        _sprite.physicsBody?.isDynamic = false
        _sprite.physicsBody?.restitution = 1.0
        _sprite.physicsBody?.friction = 0.0
        _sprite.physicsBody?.linearDamping = 0.0
        
        // Collision
        _sprite.physicsBody?.categoryBitMask = self.m_collisionBitmask
    }
    
}
