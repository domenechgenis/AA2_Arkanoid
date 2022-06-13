//
//  AppDelegate.swift
//  Arkanoid
//
//  Created by Genis Domenech Traver on 4/6/22.
//

import Foundation
import SpriteKit

extension GameScene : SKPhysicsContactDelegate
{
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if(contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask){
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else
        {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        
        //Delegates
        if(firstBody.categoryBitMask == m_ballBitmask && secondBody.categoryBitMask == m_bottomBitmask)
        {
            self.ResetBall()
            self.m_lives -= 1
            
            if(self.m_lives == 1)
            {
                self.m_racketArray[0].removeFromParent()
            }
            
            else if(self.m_lives == 0)
            {
                self.m_racketArray[1].removeFromParent()
            }
            
            //Only when lives are under 0, not equal, the player lose
            else if(self.m_lives < 0)
            {
                self.UpdateHighScore(_score: m_currentScore)
                self.HidePlayGround()
                self.ShowGameOverMenu()
            }
        }
        
        else if(firstBody.categoryBitMask == m_ballBitmask && secondBody.categoryBitMask == m_brickBitmask)
        {
            m_bricks -= 1;
            
            print(String(m_bricks) + " left in the level")
            
            //Update Score
            let brickName : String = secondBody.node!.name!
            m_currentScore += self.UpdatePlayerScore(_brick: brickName)
            m_gameScore.text = "1UP: " + String(self.m_currentScore)
            
            //Create power up
            if(!m_PowerUpSpawned)
            {
                let brickX : CGFloat = secondBody.node!.position.x
                let brickY : CGFloat = secondBody.node!.position.y
                self.CreatePowerUp(_brick: brickName, xPos: brickX, yPos: brickY)
                m_PowerUpSpawned = true
            }
            
            if(HasGameFinished())
            {
                self.UpdateHighScore(_score: m_currentScore)
                self.HidePlayGround()
            }
            
            //Remove the brick
            secondBody.node?.removeFromParent()
        }
        
        else if(firstBody.categoryBitMask == m_powerUpBitmask && secondBody.categoryBitMask == m_racketBitmask)
        {
            print("The power up reached the racket!!")
        }
        
        else if(firstBody.categoryBitMask == m_powerUpBitmask && secondBody.categoryBitMask == m_ballBitmask)
        {
            print("The power up reached the ball!!")
        }
    }

}
