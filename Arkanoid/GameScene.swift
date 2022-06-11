import GameplayKit
import SpriteKit
import CoreMotion

class GameScene: SKScene {
    
    //Game Variables
    //Constants
    let m_MenuLabelSize : CGFloat = 80
    
    //Menu Varables
    var m_background : SKSpriteNode!
    var m_logo : SKSpriteNode!
    var playButtonLabel: SKLabelNode!
    var optionsButtonLabel: SKLabelNode!
    var exitButtonLabel: SKLabelNode!
    
    
    
    var m_barTouch : UITouch?
    
    // Swift Functions
    override func didMove(to view: SKView)
    {
        //Create the Menu
        self.CreateMenu()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
          let location = touch.location(in: self)
          let touchedNode = atPoint(location)
    
          if touchedNode.name == "PlayButton"{
              print("Play Button Pressed")
          }
          else if(touchedNode.name == "OptionsButton"){
                print("Options Button Pressed")
          }
          else if(touchedNode.name == "ExitButton"){
              print("Exit Button Pressed")
          }
        }
    }
    
    // Menu Functions
    private func CreateMenu()
    {
        self.backgroundColor = .black
        
        self.addBlackBackground()
        self.addLogo()
        self.addPlayButton()
        self.addOptionsButton()
        self.addExitButton()
    }
    
    //Buttons Functions
    private func ExitPressed()
    {
        //Exit does not compliance with the iOS Human Interface Guidelines, as required by the App Store Review Guidelines.
        // But for educational pruposes, its implemented
        exit(0)
    }
    
}
