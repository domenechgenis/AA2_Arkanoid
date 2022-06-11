import GameplayKit
import SpriteKit
import CoreMotion

class GameScene: SKScene {
    //Game Variables
    //Constants
    let m_MenuLabelSize : CGFloat = 80
    
    //Menu Varables
    var m_menuBackground : SKSpriteNode!
    var m_logo : SKSpriteNode!
    var m_playButtonLabel: SKLabelNode!
    var m_creditsButtonLabel: SKLabelNode!
    var m_exitButtonLabel: SKLabelNode!
    
    //Game variables
    var m_gameBackground : SKSpriteNode!
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
        m_logo.isHidden = true
        m_playButtonLabel.isHidden = true
        m_creditsButtonLabel.isHidden = true
        m_exitButtonLabel.isHidden = true
    }
    
    private func ShowMenu()
    {
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
        self.AddGameBar()
        self.AddGameBall()
    }
    
    private func ShowPlayGround()
    {
        m_gameBackground.isHidden = false
        m_Ball.isHidden = false
        m_Bar.isHidden = false
    }
}
