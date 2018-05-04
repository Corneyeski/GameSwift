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
    let texturaFondo = SKTexture(imageNamed: "city.jpg")
    var suelo = SKSpriteNode()
    let texturaSuelo = SKTexture(imageNamed: "floor.png")
    
    
    func backgroundAnimated(){
        
        let movimientoFondo = SKAction.move(by: CGVector(dx: -texturaFondo.size().width, dy: 0), duration: 4)
        let movimientoFondoOrigen = SKAction.move(by: CGVector(dx: texturaFondo.size().width, dy: 0), duration: 0)
        let movimientoInfinitoFondo = SKAction.repeatForever(SKAction.sequence([movimientoFondo, movimientoFondoOrigen]))
        var i: CGFloat = 0
        
        while i < 3 {
            background = SKSpriteNode(texture: texturaFondo)
            background.position = CGPoint(x: texturaFondo.size().width * i, y: self.frame.midY)
            
            background.size.height = self.frame.width-self.frame.width/4
            
            background.zPosition = -1
            
            background.run(movimientoInfinitoFondo)
            self.addChild(background)
            
            i += 1
        }
    }
    
    func floor() {
        
        let movimientoSuelo = SKAction.move(by: CGVector(dx: -texturaSuelo.size().width, dy: 0), duration: 4)
        let movimientoSueloOrigen = SKAction.move(by: CGVector(dx: texturaSuelo.size().width, dy: 0), duration: 0)
        let movimientoInfinitoSuelo = SKAction.repeatForever(SKAction.sequence([movimientoSuelo, movimientoSueloOrigen]))
        var i: CGFloat = 0
       
        while i < 3 {
            
            suelo = SKSpriteNode(texture: texturaSuelo)
            suelo.size.height = background.size.height/3
            suelo.size.width = background.size.width*1.3
            
            suelo.position = CGPoint(x: texturaSuelo.size().width * i, y:  self.frame.minY + suelo.size.height / 3 )
            
            
            suelo.zPosition = 0
            print(-self.frame.minY / 2)
            print(-self.frame.width / 2)
            
            print(self.frame.height)
            print(self.frame.width)
            suelo.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: 1))
            
            suelo.physicsBody!.isDynamic = false
            
            suelo.run(movimientoInfinitoSuelo)
            self.addChild(suelo)
            
            i += 1
        }
    }
    
    override func didMove(to view: SKView) {
        
        backgroundAnimated()
        floor()
        
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
