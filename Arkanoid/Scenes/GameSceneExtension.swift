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
        self.m_gameBackground.size = CGSize(width: self.size.width - 20, height: self.size.height - 125)
        self.m_gameBackground.position = CGPoint(x: 0, y: -65)
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
        self.m_borderTop.position = CGPoint(x: 0, y: self.size.height / 2 - 125)
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
        self.m_borderLeft.position = CGPoint(x: -(self.size.width / 2), y: 0 - 125)
        self.m_borderLeft.zPosition = 1
        self.addChild(self.m_borderLeft)
        
        // Right
        self.m_borderRight = SKSpriteNode(imageNamed: "border_right")
        self.m_borderRight.name = "borderRight"
        self.m_borderRight.size = CGSize(width: m_GameBorderSize, height: self.size.height)
        self.m_borderRight.position = CGPoint(x: (self.size.width / 2), y: 0 - 125)
        self.m_borderRight.zPosition = 1
        self.addChild(self.m_borderRight)
        
        self.AddStaticphysics(_border: m_borderTop)
        self.AddStaticphysics(_border: m_borderLeft)
        self.AddStaticphysics(_border: m_borderRight)
        
        //Hide it
        self.m_borderLeft.isHidden = true
        self.m_borderRight.isHidden = true
        self.m_borderTop.isHidden = true
    }
    
    func AddBricks()
    {
        //Remove old parameters
        bricksArray.removeAll()
        m_bricks = 0
        
        //Initial offset with the borders
        var startX = -(self.size.width / 2) + 50
        var startY = (self.size.height / 2) - 200
        var wantedColor = "blue"
        
        for i in 1 ... m_Rows
        {
            for _ in 1 ... m_Columns
            {
                // Offset with each brick
                AddSingleBrick(xPos: startX, yPos: startY,wantedColor: wantedColor)
                startX += 50
            }
            
            wantedColor = GetNextColorBrick(index: i)
            startX = -(self.size.width / 2) + 50
            startY -= 50.0
        }
        
        print("Level should have : " + String(m_Rows * self.m_Columns) + " blocks.")
        print("Level created with: " + String(m_bricks) + " blocks.")
    }
    
    func GetNextColorBrick(index : Int) -> String {
        if(index == 1)
        {
            return "green";
        }
        else if ( index == 2)
        {
            return "pink"
        }
        else if ( index == 3)
        {
            return "red"
        }
        else
        {
            return "yellow"
        }
    }
    
    func AddSingleBrick(xPos: CGFloat, yPos : CGFloat, wantedColor : String)
    {
        let brick = SKSpriteNode(imageNamed: "block_" + wantedColor)
        brick.name = "block_" + wantedColor
        brick.size = CGSize(width: brick.size.width * 3, height: brick.size.height * 3)
        brick.position = CGPoint(x: xPos, y: yPos)
        brick.zPosition = 2
        
        // Physics
        brick.physicsBody = SKPhysicsBody(rectangleOf: brick.frame.size)
        brick.physicsBody?.friction = 0
        brick.physicsBody?.allowsRotation = false
        brick.physicsBody?.isDynamic = false

        //BitMask
        brick.physicsBody?.categoryBitMask = m_brickBitmask
        
        //Hide it
        brick.isHidden = true
                
        //Brick Counter
        bricksArray.append(brick)
        m_bricks = m_bricks + 1
        
        self.addChild(brick)
    }
    
    func AddGameRacket()
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
    
    func AddRacketsUI()
    {
        m_lives = 2
        m_racketArray.removeAll()
        
        var offsetX : CGFloat = -250
        let offsetY : CGFloat = -(self.size.height / 2) + 50
        //Add Health represented in UI
        for _ in 1 ... m_lives
        {
            AddSingleUI(xPos: offsetX, yPos: offsetY)
            offsetX -= 50
        }
    }
    
    func AddTopUI()
    {
        //Reference Variables
        self.m_gameScore = SKLabelNode(text: "1UP: " + String(self.m_currentScore))
        self.m_gameScore.position = CGPoint(x: -(self.size.width / 2) + 150, y: self.size.height / 2 - 100)
        self.m_gameScore.fontColor = UIColor.white
        self.m_gameScore.fontSize = self.m_gameLabelSize
        self.m_gameScore.zPosition = 2
        
        self.m_gameScore.isHidden = true
        self.addChild(self.m_gameScore)
        
        //Reference Variables
        self.m_gameHighScore = SKLabelNode(text: "HIGH SCORE: " + String(self.m_maxHighScore))
        self.m_gameHighScore.position = CGPoint(x: -(self.size.width / 2) + 500, y: self.size.height / 2 - 100)
        self.m_gameHighScore.fontColor = UIColor.white
        self.m_gameHighScore.fontSize = self.m_gameLabelSize
        self.m_gameHighScore.zPosition = 2
        
        self.m_gameScore.isHidden = true
        self.addChild(self.m_gameHighScore)
    }
    
    func AddSingleUI(xPos: CGFloat, yPos : CGFloat)
    {
        let auxracketUI = SKSpriteNode(imageNamed: "racket")
        auxracketUI.name = "racketUI"
        auxracketUI.size = CGSize(width: auxracketUI.size.width * 1.5, height : auxracketUI.size.height * 1.5)
        auxracketUI.position = CGPoint(x: xPos, y: yPos)
        auxracketUI.zPosition = 2
        
        //Hide it
        auxracketUI.isHidden = true
                
        //Brick Counter
        m_racketArray.append(auxracketUI)
        
        self.addChild(auxracketUI)
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
    
    func AddStaticphysics(_border : SKSpriteNode)
    {
        // Physics
        _border.physicsBody = SKPhysicsBody(rectangleOf: _border.frame.size)
        _border.physicsBody?.friction = 0.4
        _border.physicsBody?.restitution = 0.1
        _border.physicsBody?.isDynamic = false
        
        //BitMask
        _border.physicsBody?.categoryBitMask = m_racketBitmask
    }
    
    // GAME OVER FUNCTIONS
    
    func AddTextLabel()
    {
        //Reference Variables
        self.m_gameOverTopTextLabel = SKLabelNode(text: "Game Over")
        self.m_gameOverTopTextLabel.name = "RetryButton"
        
        self.m_gameOverTopTextLabel.fontColor = UIColor.white
        self.m_gameOverTopTextLabel.fontSize = self.m_menuLabelSize
    
        self.m_gameOverTopTextLabel.position = CGPoint(x: 0, y: 150)
        self.m_gameOverTopTextLabel.zPosition = 1
        
        
        self.m_gameOverTopTextLabel.isHidden = true
        
        self.addChild(self.m_gameOverTopTextLabel)
    }
    
    func AddGamOverRetryButton()
    {
        //Reference Variables
        self.m_gameOverRetryButtonLabel = SKLabelNode(text: "Retry")
        self.m_gameOverRetryButtonLabel.name = "RetryButton"
        
        self.m_gameOverRetryButtonLabel.fontColor = UIColor.white
        self.m_gameOverRetryButtonLabel.fontSize = self.m_menuLabelSize
    
        self.m_gameOverRetryButtonLabel.position = CGPoint(x: 0, y: 0)
        self.m_gameOverRetryButtonLabel.zPosition = 1
        
        self.m_gameOverRetryButtonLabel.isHidden = true
        
        self.addChild(self.m_gameOverRetryButtonLabel)
    }

    func AddGameOverExitButton()
    {
        //Reference Variables
        self.m_gameOverExitButtonLabel = SKLabelNode(text: "Exit")
        self.m_gameOverExitButtonLabel.name = "ExitButton"
        
        self.m_gameOverExitButtonLabel.fontColor = UIColor.white
        self.m_gameOverExitButtonLabel.fontSize = self.m_menuLabelSize
        self.m_gameOverExitButtonLabel.position = CGPoint(x: 0, y: -150)
        self.m_gameOverExitButtonLabel.zPosition = 1
        
        self.m_gameOverExitButtonLabel.isHidden = true
        
        self.addChild(self.m_gameOverExitButtonLabel)
    }

}
