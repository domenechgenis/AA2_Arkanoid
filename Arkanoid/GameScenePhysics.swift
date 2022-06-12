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
        }
        
        else if(firstBody.categoryBitMask == m_ballBitmask && secondBody.categoryBitMask == m_brickBitmask)
        {
            secondBody.node?.removeFromParent()
            
            if(true)
            {
                let transition:SKTransition = SKTransition.fade(withDuration: 1)
                let scene : SKScene = GameOverScene(size: self.frame.size)
                scene.scaleMode = .aspectFit
                self.view?.presentScene(scene,transition: transition)
            }
        
        }
    }
    
    func HasGameFinished() -> Bool {
        return m_bricks.isEmpty
    }
}