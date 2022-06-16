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
// -> Change between scenes instead of hide
// -> Sounds and music
// -> Power Ups
// -> Test

// Not working
// -> Transition Between Scenes

class GameScene: SKScene{
    
    // Game Variables
    // Constants
    let m_menuLabelSize : CGFloat = 80
    let m_gameLabelSize : CGFloat = 40
    let m_GameBorderSize : CGFloat = 30
    let m_initialBallVelocity = CGVector(dx: 400, dy: -400)
    let m_initialBallImpulse = CGVector(dx: 10, dy: -10)
    let m_Rows : Int = 5
    let m_Columns : Int = 14
    
    // Collisions Mask
    let m_ballBitmask : UInt32 = 0x1 << 0       // 000000000
    let m_bottomBitmask : UInt32 = 0x1 << 1     // 000000001
    let m_brickBitmask : UInt32 = 0x1 << 2      // 000000010
    let m_racketBitmask : UInt32 = 0x1 << 3     // 000001000
    let m_powerUpBitmask : UInt32 = 0x1 << 4    // 000010000
    
    // Keys
    let m_HighScoreKey : String = "HighScore"
    
    // Menu Varables
    var m_logo : SKSpriteNode!
    var m_playButtonLabel: SKLabelNode!
    var m_creditsButtonLabel: SKLabelNode!
    var m_exitButtonLabel: SKLabelNode!
    
    //Game variables
    var m_gameBackground : SKSpriteNode!
    var m_gameScore: SKLabelNode!
    var m_gameHighScore: SKLabelNode!
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
    var m_currentScore : Int = 0
    var m_maxHighScore : Int = 0
    var m_PowerUpSpawned : Bool = false
    
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
        self.AddTopUI()
        self.AddRacketsUI()
        self.AddBricks()
        self.AddGameRacket()
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
        
        self.AddBricks()
        
        //Recreate bricks
        for bricksArray in bricksArray {
            bricksArray.isHidden = false
        }
        
        self.AddRacketsUI()
        
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
            bricksArray.removeFromParent()
        }
    }
    
    private func StartGame()
    {
        //Reset lives
        m_lives = 2
        
        // Reset Score
        m_currentScore = 0
        m_gameScore.text = "1UP: " + String(self.m_currentScore)
        
        //Reset ball velocity
        m_Ball.physicsBody?.velocity = m_initialBallVelocity
        
        m_gameScore.isHidden = false
        m_gameHighScore.isHidden = false
        
        
        print("Game Started!")
    }
    
    public func ResetBall()
    {
        //TODO -> Change to random point
        let action : SKAction
        action = SKAction.moveTo(y: 100, duration: 0)
        action.timingMode = .easeInEaseOut
        self.m_Ball.run(action)
        
        //Reset ball velocity
        m_Ball.physicsBody?.velocity = m_initialBallVelocity
    }
    
    private func CreateWorldSettings()
    {
        let worldBorder = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody = worldBorder
        self.physicsBody?.friction = 0
        self.physicsWorld.gravity = .zero
        self.physicsWorld.contactDelegate = self
        
        //Get High score from locals
        let defaults : UserDefaults = .standard
        let storedHighScore = defaults.integer(forKey: m_HighScoreKey)
        print("Founded the following value stored:" + String(storedHighScore))
        m_maxHighScore = storedHighScore
    }
    
    func UpdateHighScore(_score : Int)
    {
        if(_score > m_maxHighScore)
        {
            m_maxHighScore = _score
            let defaults : UserDefaults = .standard
            defaults.setValue(m_maxHighScore, forKey: m_HighScoreKey)
        }
    }
    
    func CreateGameOverMenu()
    {
        self.AddTextLabel()
        self.AddGamOverRetryButton()
        self.AddGameOverExitButton()
    }
    
    func HasGameFinished() -> Bool {
        return m_bricks <= 0
    }
    
    func UpdatePlayerScore(_brick : String) -> Int
    {
        var score : Int = 10
        switch _brick {
        case "block_yellow":
            score = 10
        case "block_red":
            score = 20
        case "block_pink":
            score = 30
        case "block_green":
            score = 40
        case "block_blue":
            score = 50
        default:
            print("Block color not identified!!!")
        }
        return score
    }
    
    func CreatePowerUp(_brick : String, xPos : CGFloat, yPos : CGFloat)
    {
        let brick = SKSpriteNode(imageNamed: _brick)
        brick.size = CGSize(width: brick.size.width * 3, height: brick.size.height * 3)
        brick.position = CGPoint(x: 0, y: -(self.size.height / 2) + 400)
        brick.zPosition = 2
        
        brick.physicsBody = SKPhysicsBody(rectangleOf: brick.frame.size)
        brick.physicsBody?.friction = 0
        brick.physicsBody?.restitution = 1
        brick.physicsBody?.linearDamping = 0
        brick.physicsBody?.allowsRotation = false
        brick.physicsBody?.velocity = CGVector(dx: 0, dy: -100)
        
        //BitMask
        brick.physicsBody?.categoryBitMask = m_powerUpBitmask
        brick.physicsBody?.contactTestBitMask = m_racketBitmask | m_ballBitmask | m_bottomBitmask
        
        self.addChild(brick)
        
        print("Power up created!")
    }
}
