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
            if(m_PowerUpBallApplied)
            {
                if (firstBody.node?.name! == self.m_BallAux.name)
                {
                    firstBody.node?.removeFromParent()
                    m_PowerUpBallApplied = false
                }
            }else{
                
                self.m_lives -= 1
                self.ResetBall()
                
                if(self.m_lives >= 0){
                    self.m_racketArray[m_lives].removeFromParent()
                }
                
                //Only when lives are under 0, not equal, the player lose
                else if(self.m_lives < 0)
                {
                    self.UpdateHighScore(_score: m_currentScore)
                    self.HidePlayGround()
                    self.ShowGameOverMenu()
                }
            }
            
            
        }
                
        if(firstBody.categoryBitMask == m_ballBitmask && secondBody.categoryBitMask == m_brickBitmask)
        {
            m_bricks -= 1
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
        
        if(firstBody.categoryBitMask == m_ballBitmask && secondBody.categoryBitMask == m_powerUpBitmask)
        {
            //This is not working and I couldn't fixed
            //Remove the power up
            print("The ball hitted the power up!!")
            secondBody.node?.removeFromParent()
        }
    }
}
