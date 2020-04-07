//
//  GameScene.swift
//  Pong
//
//  Created by Dylan Carlson on 4/5/20.
//  Copyright © 2020 Dylan Carlson. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    
    var enemyScoreLabel = SKLabelNode()
    var mainScoreLabel = SKLabelNode()
    
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        main = self.childNode(withName: "main") as! SKSpriteNode
        
        enemyScoreLabel = self.childNode(withName: "topLabel") as! SKLabelNode
        mainScoreLabel = self.childNode(withName: "bottomLabel") as! SKLabelNode
        
        startGame()
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        

    }
    
    func startGame() {
        score = [0,0]
        enemyScoreLabel.text = "\(score[1])"
        mainScoreLabel.text = "\(score[0])"
        ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
    }
    
    func addScore(playerWhoWon: SKSpriteNode) {
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == main {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
            mainScoreLabel.text = "\(score[0])"
        }
        else if playerWhoWon == enemy {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -20, dy: -20))
            enemyScoreLabel.text = "\(score[1])"
        }
        
        print("Player: \(score[0]) Enemy: \(score[1])")
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if location.y > 0  && currentGameType == .player2 {
                enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
            else if location.y <= 0 {
                main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if location.y > 0 && currentGameType == .player2 {
                enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
            else if location.y <= 0 {
                main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        switch currentGameType {
        case .easy:
            enemy.run(SKAction.moveTo(x: ball.position.x - 30, duration: 1.5))
            break
        case .medium:
            enemy.run(SKAction.moveTo(x: ball.position.x - 30, duration: 1.0))
            break
        case .hard:
            enemy.run(SKAction.moveTo(x: ball.position.x - 30, duration: 0.2))
            break
        case .player2:
            break
        case .none:
            break
        }
        
        if ball.position.y <= main.position.y - 70 {
            addScore(playerWhoWon: enemy)
        }
        else if ball.position.y >= enemy.position.y + 70 {
            addScore(playerWhoWon: main)
        }
        
    }
}
