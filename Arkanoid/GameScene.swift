import GameplayKit
import SpriteKit
import CoreMotion

class GameScene: SKScene {
    
    //Game Variables
    //Constants
    let m_menuLabelSize : CGFloat = 80
    let m_GameBorderSize : CGFloat = 30
    let m_initialBallSpeed = CGVector(dx: 200, dy: 200)
    let m_collisionBitmask : UInt32 = 0b0001
    
    //Menu Varables
    var m_menuBackground : SKSpriteNode!
    var m_logo : SKSpriteNode!
    var m_playButtonLabel: SKLabelNode!
    var m_creditsButtonLabel: SKLabelNode!
    var m_exitButtonLabel: SKLabelNode!
    
    //Game variables
    var m_gameBackground : SKSpriteNode!
    var m_borderTop : SKSpriteNode!
    var m_borderLeft : SKSpriteNode!
    var m_borderRight : SKSpriteNode!
    var m_Bar : SKSpriteNode!
    var m_Ball : SKSpriteNode!
    
    // Swift Functions
    override func didMove(to view: SKView)
    {
        //Create the Menu and show it
        self.CreateMenu()
        
        // Create the Game and keet it hided until press play
        self.CreateGame()
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
            else if(touchedNode.name == m_creditsButtonLabel.name){
                print("Credits Button Pressed")
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
            self.m_Bar.run(action)
        }
        
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        //Control Ball
        if(m_Ball.position.y < -(self.size.height / 2))
        {
            ResetBall()
        }
    }
        
    
    // Menu Functions
    private func CreateMenu()
    {
        self.AddMenuBackground()
        self.AddMenuLogo()
        self.AddMenuPlayButton()
        self.AddMenuCreditsButton()
        self.AddMenuExitButton()
    }
    
    private func HideMenu()
    {
        m_menuBackground.isHidden = true
        m_logo.isHidden = true
        m_playButtonLabel.isHidden = true
        m_creditsButtonLabel.isHidden = true
        m_exitButtonLabel.isHidden = true
    }
    
    private func ShowMenu()
    {
        m_menuBackground.isHidden = false
        m_logo.isHidden = false
        m_playButtonLabel.isHidden = false
        m_creditsButtonLabel.isHidden = false
        m_exitButtonLabel.isHidden = false
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
        //Exit does not compliance with the iOS Human Interface Guidelines, as required by the App Store Review Guidelines.
        // But for educational pruposes, its implemented
        exit(0)
    }
    
    // Game Functions
    private func CreateGame()
    {
        self.AddGameBackground()
        self.AddBorders()
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
        m_Bar.isHidden = false
        
        //All Enabled, start game
        StartGame()
    }
    
    private func StartGame()
    {
        m_Ball.physicsBody?.velocity = m_initialBallSpeed
    }
    
    private func ResetBall()
    {
        //TODO -> Change to random point
        m_Ball.position = CGPoint(x: 0, y: 0)
        m_Ball.physicsBody?.velocity = m_initialBallSpeed
    }
}
