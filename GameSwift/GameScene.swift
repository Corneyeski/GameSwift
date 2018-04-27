//
//  GameScene.swift
//  GameSwift
//
//  Created by DAM on 25/4/18.
//  Copyright © 2018 DAM. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    var background = SKSpriteNode()
    
    
    func backgroundAnimated(){
        
        // Textura para el fondo
        let texturaFondo = SKTexture(imageNamed: "city.jpg")
        
        let movimientoFondo = SKAction.move(by: CGVector(dx: -texturaFondo.size().width, dy: 0), duration: 4)
        let movimientoFondoOrigen = SKAction.move(by: CGVector(dx: texturaFondo.size().width, dy: 0), duration: 0)
        let movimientoInfinitoFondo = SKAction.repeatForever(SKAction.sequence([movimientoFondo, movimientoFondoOrigen]))
        var i: CGFloat = 0
        
        while i < 2 {
            background = SKSpriteNode(texture: texturaFondo)
            background.position = CGPoint(x: texturaFondo.size().width * i, y: self.frame.midY)
            
            background.size.height = self.frame.width-self.frame.width/3
            
            // Indicamos zPosition para que quede detrás de todo
            background.zPosition = -1
            
            background.run(movimientoInfinitoFondo)
            self.addChild(background)
            
            i += 1
        }
        
    }
    
    func floor() {
        var suelo = SKSpriteNode()
        let texturaFondo = SKTexture(imageNamed: "city.jpg")
        
        suelo.position = CGPoint(x: self.frame.midX, y: -self.frame.height )
        
        suelo.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: 1))
        // el suelo se tiene que estar quieto
        suelo.physicsBody!.isDynamic = false
        
        suelo = SKSpriteNode(texture: texturaFondo)
        
        self.addChild(suelo)
    }
    
    
    override func didMove(to view: SKView) {
        
        backgroundAnimated()
        
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
