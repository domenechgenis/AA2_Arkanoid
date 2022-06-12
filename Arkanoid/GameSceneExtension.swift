//
//  AppDelegate.swift
//  Arkanoid
//
//  Created by Genis Domenech Traver on 4/6/22.
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
        
        // Bottom
        let m_bottomRect = CGRect(x: self.frame.origin.x,y: self.frame.origin.y,width: self.frame.size.width,height: 1)
        let bottom = SKNode()
        bottom.physicsBody = SKPhysicsBody(edgeLoopFrom: m_bottomRect)
        self.addChild(bottom)
        bottom.physicsBody?.categoryBitMask = m_bottomBitmask
        
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
        
        //Hide it
        self.m_borderLeft.isHidden = true
        self.m_borderRight.isHidden = true
        self.m_borderTop.isHidden = true
    }
    
    func AddBricks()
    {
        var startX = -(self.size.width / 2) + 85
        var startY = (self.size.height / 2) - 200
        
        for index in 1 ... m_Rows
        {
            for index in 1 ... m_Columns
            {
                AddSingleBrick(xPos: startX, yPos: startY)
                startX += 150
            }
            startX = -(self.size.width / 2) + 85
            startY -= 50.0
        }
        
        print("Level created with: " + String(m_bricks.count) + " blocks.")
    }
    
    func AddSingleBrick(xPos: CGFloat, yPos : CGFloat)
    {
        var brick = SKSpriteNode(imageNamed: "block_blue")
        brick.name = "brick0"
        brick.size = CGSize(width: brick.size.width * 5, height: brick.size.height * 3)
        brick.position = CGPoint(x: xPos, y: yPos)
        brick.zPosition = 2
        
        // Physics
        brick.physicsBody = SKPhysicsBody(rectangleOf: brick.frame.size)
        brick.physicsBody?.friction = 0
        brick.physicsBody?.allowsRotation = false
        brick.physicsBody?.isDynamic = false

        //BitMask
        brick.physicsBody?.categoryBitMask = m_brickBitmask
                
        var newBrick: Brick
        newBrick = Brick(_xPos: 0, _yPos: Int(-(self.size.height / 2) + 500), _requiredHits: 1)
        m_bricks.append(newBrick)
        
        self.addChild(brick)
    }
    
    func AddGameBar()
    {
        self.m_Racket = SKSpriteNode(imageNamed: "racket")
        self.m_Racket.name = "racket"
        
        self.m_Racket.size = CGSize(width: m_Racket.size.width * 3, height: m_Racket.size.height * 3)
        self.m_Racket.position = CGPoint(x: 0, y: -(self.size.height / 2) + 100)
        self.m_Racket.zPosition = 2
        self.addChild(self.m_Racket)
    
        // Hide it
        self.m_Racket.isHidden = true
        
        // Physics
        self.m_Racket.physicsBody = SKPhysicsBody(rectangleOf: m_Racket.frame.size)
        self.m_Racket.physicsBody?.friction = 0.4
        self.m_Racket.physicsBody?.restitution = 0.1
        self.m_Racket.physicsBody?.isDynamic = false
        
        //BitMask
        self.m_Racket.physicsBody?.categoryBitMask = m_racketBitmask

    }
    
    func AddGameBall()
    {
        self.m_Ball = SKSpriteNode(imageNamed: "ball")
        self.m_Ball.name = "ball"
        self.m_Ball.size = CGSize(width: m_Ball.size.width * 4, height: m_Ball.size.height * 4)
        self.m_Ball.position = CGPoint(x: 0, y: 0)
        self.m_Ball.zPosition = 2
        self.addChild(self.m_Ball)
                
        // Hide it
        self.m_Ball.isHidden = true
        
        // Physics
        self.m_Ball.physicsBody = SKPhysicsBody(circleOfRadius: self.m_Ball.frame.size.width / 2)
        self.m_Ball.physicsBody?.friction = 0
        self.m_Ball.physicsBody?.restitution = 1
        self.m_Ball.physicsBody?.linearDamping = 0
        self.m_Ball.physicsBody?.allowsRotation = false
        
        //BitMask
        self.m_Ball.physicsBody?.categoryBitMask = m_ballBitmask
        self.m_Ball.physicsBody?.contactTestBitMask = m_bottomBitmask | m_brickBitmask  
        
    }
    
    struct Brick
    {
        var xPos: Int
        var yPos: Int
        var requiredHits: Int

        init(_xPos: Int, _yPos: Int, _requiredHits: Int)
        {
            self.xPos = _xPos
            self.yPos = _yPos
            self.requiredHits = _requiredHits
        }
    }
}
