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
            
            print(self.m_lives)
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
                self.HidePlayGround()
                self.ShowGameOverMenu()
            }
        }
        
        else if(firstBody.categoryBitMask == m_ballBitmask && secondBody.categoryBitMask == m_brickBitmask)
        {
            secondBody.node?.removeFromParent()
            m_bricks -= 1;
            
            print(String(m_bricks) + " left.")
 
            if(HasGameFinished())
            {
                self.HidePlayGround()
            }
        
        }
    }
    
    func HasGameFinished() -> Bool {
        return m_bricks <= 0
    }
}
