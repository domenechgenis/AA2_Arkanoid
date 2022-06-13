//
//  AppDelegate.swift
//  Arkanoid
//
//  Created by Genis Domenech Traver on 4/6/22.
//

import GameplayKit
import SpriteKit
import CoreMotion

//TODO
// -> Physics
// -> Test

// Not working
// -> Transition Between Scenes

class GameScene: SKScene{
    
    //Game Variables
    //Constants
    let m_menuLabelSize : CGFloat = 80
    let m_GameBorderSize : CGFloat = 30
    let m_initialBallVelocity = CGVector(dx: 400, dy: -400)
    let m_initialBallImpulse = CGVector(dx: 10, dy: -10)
    let m_Rows : Int = 5
    let m_Columns : Int = 14
    
    let m_ballBitmask : UInt32 = 0x1 << 0       // 000000000
    let m_bottomBitmask : UInt32 = 0x1 << 1     // 000000001
    let m_brickBitmask : UInt32 = 0x1 << 2      // 000000010
    let m_racketBitmask : UInt32 = 0x1 << 3     // 000001000
    
    //Menu Varables
    var m_logo : SKSpriteNode!
    var m_playButtonLabel: SKLabelNode!
    var m_creditsButtonLabel: SKLabelNode!
    var m_exitButtonLabel: SKLabelNode!
    
    //Game variables
    var m_gameBackground : SKSpriteNode!
    var m_borderTop : SKSpriteNode!
    var m_borderLeft : SKSpriteNode!
    var m_borderRight : SKSpriteNode!
    var m_racketArray : [SKSpriteNode] = []
    var m_Racket : SKSpriteNode!
    var m_Ball : SKSpriteNode!
    
    //Game over variables
    var m_gameOverTopTextLabel : SKLabelNode!
    var m_gameOverScoreLabel : SKLabelNode!
    var m_gameOverMaxScoreLabel : SKLabelNode!
    var m_gameOverRetryButtonLabel: SKLabelNode!
    var m_gameOverMainMenuButtonLabel: SKLabelNode!
    var m_gameOverExitButtonLabel: SKLabelNode!
    var m_gameOverDoneByLabel: SKLabelNode!
    
    // Game info
    var bricksArray : [SKSpriteNode] = []
    var m_bricks : Int = 0
    var m_lives : Int = 2
    
    override func didMove(to view: SKView)
    {
        // Create Settings of the world
        self.CreateWorldSettings()
        
        // Create the Menu and show it
        self.CreateMenu()
        
        // Create the Game and keet it hided until press play
        self.CreateGame()
        
        // Create the Game over and keeit it hided until player lose
        self.CreateGameOverMenu()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //Menu Touches
        for touch in touches {
          let location = touch.location(in: self)
          let touchedNode = atPoint(location)
    
          if (touchedNode.name == m_playButtonLabel.name){
              print("Play Button Pressed")
                PlayPressed()
          }
            else if(touchedNode.name == m_gameOverRetryButtonLabel.name){
                RetryPressed()
          }
            else if(touchedNode.name == m_creditsButtonLabel.name){
                CreditsPressed()
          }
            else if(touchedNode.name == m_exitButtonLabel.name){
              print("Exit Button Pressed")
                ExitPressed()
          }
        }
        
        //Game Touches
        if let touch = touches.first{
            let position = touch.location(in:self)
            let action : SKAction
            action = SKAction.moveTo(x: position.x, duration: 0.05)
            action.timingMode = .easeInEaseOut
            self.m_Racket.run(action)
        }
        
    }
            
    // Menu Functions
    private func CreateMenu()
    {
        //Change background
        self.backgroundColor = .black
        
        self.AddMenuLogo()
        self.AddMenuPlayButton()
        self.AddMenuCreditsButton()
        self.AddMenuExitButton()
    }
    
    private func RetryPressed()
    {
        HideGameOverMenu()
        ShowPlayGround()
        StartGame()
    }
    
    private func HideMenu()
    {
        m_logo.isHidden = true
        m_playButtonLabel.isHidden = true
        m_creditsButtonLabel.isHidden = true
        m_exitButtonLabel.isHidden = true
    }
    
    func ShowMenu()
    {
        m_logo.isHidden = false
        m_playButtonLabel.isHidden = false
        m_creditsButtonLabel.isHidden = false
        m_exitButtonLabel.isHidden = false
    }
    
    func ShowGameOverMenu()
    {
        m_gameOverTopTextLabel.isHidden = false
        m_gameOverRetryButtonLabel.isHidden = false
        m_gameOverExitButtonLabel.isHidden = false
    }
    
    private func HideGameOverMenu()
    {
        m_gameOverTopTextLabel.isHidden = true
        m_gameOverRetryButtonLabel.isHidden = true
        m_gameOverExitButtonLabel.isHidden = true
    }
    
    
    //Buttons Functions
    private func ExitPressed()
    {
        //Exit does not compliance with the iOS Human Interface Guidelines, as required by the App Store Review Guidelines.
        // But for educational pruposes, its implemented
        exit(0)
    }
    
    private func PlayPressed()
    {
        HideMenu()
        ShowPlayGround()
    }
    
    private func CreditsPressed()
    {
        let reveal = SKTransition.reveal(with: .down,duration: 1)
        let newScene = GameOverScene(size: CGSize(width: self.frame.width, height: self.frame.height))
        view?.presentScene(newScene,transition: reveal)
    }
    
    // Game Functions
    private func CreateGame()
    {
        self.AddGameBackground()
        self.AddBorders()
        self.AddUI()
        self.AddBricks()
        self.AddGameBar()
        self.AddGameBall()
    }
    
    private func ShowPlayGround()
    {
        m_gameBackground.isHidden = false
        m_borderTop.isHidden = false
        m_borderLeft.isHidden = false
        m_borderRight.isHidden = false
        m_Ball.isHidden = false
        m_Racket.isHidden = false
        
        for bricksArray in bricksArray {
            bricksArray.isHidden = false
        }
                
        for racketArray in m_racketArray {
            racketArray.isHidden = false
        }
        
        //All Enabled, start game
        StartGame()
    }
    
    func HidePlayGround()
    {
        m_gameBackground.isHidden = true
        m_borderTop.isHidden = true
        m_borderLeft.isHidden = true
        m_borderRight.isHidden = true
        m_Ball.isHidden = true
        m_Racket.isHidden = true
        
        for bricksArray in bricksArray {
            bricksArray.isHidden = true
        }
    }
    
    private func StartGame()
    {
        //Reset lives
        m_lives = 2
        
        //Reset ball velocity
        //m_Ball.physicsBody?.applyImpulse(m_initialBallSpeed)
        m_Ball.physicsBody?.velocity = m_initialBallVelocity
    }
    
    public func ResetBall()
    {
        //TODO -> Change to random point
        let action : SKAction
        action = SKAction.moveTo(y: 0, duration: 0)
        action.timingMode = .easeInEaseOut
        self.m_Ball.run(action)
        
        //Reset ball velocity
        //m_Ball.physicsBody?.applyImpulse(m_initialBallSpeed)
        m_Ball.physicsBody?.velocity = m_initialBallVelocity
    }
    
    private func CreateWorldSettings()
    {
        let worldBorder = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody = worldBorder
        self.physicsBody?.friction = 0
        self.physicsWorld.gravity = .zero
        self.physicsWorld.contactDelegate = self
    }
    
    
    func CreateGameOverMenu()
    {
        self.AddTextLabel()
        self.AddGamOverRetryButton()
        self.AddGameOverExitButton()
    }
}
