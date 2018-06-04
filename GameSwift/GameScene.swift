//
//  GameScene.swift
//  GameSwift
//
//  Created by DAM on 25/4/18.
//  Copyright © 2018 DAM. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    var gameOver = false
    
    var labelPuntuacion = SKLabelNode()
    var puntuacion = 0
    
    var rock = SKSpriteNode()
    var textRock = SKTexture(imageNamed: "rock.png")
    
    var timer = Timer()
    
    var cantidadAleatoria = CGFloat()
    var compensacionRock = CGFloat()
    
    var background = SKSpriteNode()
    let texturaFondo = SKTexture(imageNamed: "city.jpg")
    var suelo = SKSpriteNode()
    let texturaSuelo = SKTexture(imageNamed: "floor.png")
    
    var goku = SKSpriteNode()
    
    let textGoku1 = SKTexture(imageNamed: "correr.png")
    let textGoku2 = SKTexture(imageNamed: "correr2.png")
    let textGoku3 = SKTexture(imageNamed: "correr3.png")
    let textGoku4 = SKTexture(imageNamed: "correr4.png")
    let textGoku5 = SKTexture(imageNamed: "correr5.png")
    let textGoku6 = SKTexture(imageNamed: "correr6.png")
    let textGoku7 = SKTexture(imageNamed: "correr7.png")
    let textGoku8 = SKTexture(imageNamed: "correr8.png")
    
    var timerPuntuacion = Timer()
    
    enum tipoNodo: UInt32 {
        case goku = 1
        case suelo = 3
        case object = 2
    }
    
    func ponerPuntuacion() {
        labelPuntuacion.fontName = "Arial"
        labelPuntuacion.fontSize = 40
        labelPuntuacion.text = "0"
        labelPuntuacion.position = CGPoint(x: self.frame.minX/1.1, y: self.frame.maxY/1.5)
        labelPuntuacion.zPosition = 2
        self.addChild(labelPuntuacion)
    }
    
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
            
            suelo.position = CGPoint(x: texturaSuelo.size().width*i, y:  self.frame.minY + suelo.size.height / 3 )
            
            
            suelo.zPosition = 0
            print(-self.frame.minY / 2)
            print(-self.frame.width / 2)
            
            print(self.frame.height)
            print(self.frame.width)
            suelo.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width*3, height: 1))
            
            suelo.physicsBody!.isDynamic = false
            
            suelo.physicsBody!.collisionBitMask = tipoNodo.goku.rawValue
            
            suelo.run(movimientoInfinitoSuelo)
            self.addChild(suelo)
            
            i += 1
        }
    }
    
    @objc func objects() {
        // Acción para mover los tubos
        let moverRock = SKAction.move(by: CGVector(dx: -3 * self.frame.width, dy: 0), duration: TimeInterval(self.frame.width / 80))
        
        let borrarRock = SKAction.removeFromParent()
        
        let moverBorrarRock = SKAction.sequence([moverRock, borrarRock])

        rock = SKSpriteNode(texture: textRock)
        rock.position = CGPoint(x: self.frame.midX + self.frame.width, y: self.frame.midY - textRock.size().height*3.1)
        
        rock.physicsBody = SKPhysicsBody(rectangleOf: textRock.size())
        rock.physicsBody!.isDynamic = false
        
        rock.physicsBody!.categoryBitMask = tipoNodo.object.rawValue
        
        rock.physicsBody!.collisionBitMask = tipoNodo.goku.rawValue
        
        rock.physicsBody!.contactTestBitMask = tipoNodo.goku.rawValue
        
        rock.run(moverBorrarRock)
        
        self.addChild(rock)
    }
    
    func gokuRun() {
        let animacion = SKAction.animate(with: [textGoku1,textGoku2,textGoku3, textGoku4, textGoku5, textGoku6, textGoku7, textGoku8], timePerFrame: 0.2)
        
        let animacionRepetida = SKAction.repeatForever(animacion)
        goku = SKSpriteNode(texture: textGoku1)
        goku.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        
        goku.physicsBody = SKPhysicsBody(circleOfRadius: textGoku1.size().height/2)
        goku.physicsBody?.isDynamic = true
        
        goku.physicsBody!.categoryBitMask = tipoNodo.goku.rawValue
        goku.physicsBody!.categoryBitMask = tipoNodo.suelo.rawValue
        
        goku.run(animacionRepetida)

        self.addChild(goku)
        
        
    }
    
    override func didMove(to view: SKView) {
        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.objects), userInfo: nil, repeats: true)
        
        self.physicsWorld.contactDelegate = self
        
        backgroundAnimated()
        floor()
        gokuRun()
        objects()
        ponerPuntuacion()
        
        timerPuntuacion = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(puntuasao(data: )), userInfo: nil, repeats: true)
    }
    
    @objc func puntuasao(data:Timer){
        puntuacion += 1
        labelPuntuacion.text = String(puntuacion)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        if gameOver == false {
            
            // Le damos una velocidad a la mosquita para que la velocidad al caer sea constante
            goku.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
            
            
            print("ANTES---suelo Y: \(suelo.position.y) goku Y: \(goku.position.y)")
            print("ANTES---resta \(suelo.position.y-goku.position.y)")
            
            // Le aplicamos un impulso a la mosquita para que suba cada vez que pulsemos la pantalla
            // Y así poder evitar que se caiga para abajo
            //if (suelo.position.y-goku.position.y) > -19.06{
                goku.physicsBody!.applyImpulse(CGVector(dx: 0, dy: 30))
                print("resta \(suelo.position.y-goku.position.y)")
            //}
            
            print("suelo Y: \(suelo.position.y) goku Y: \(goku.position.y)")
        } else {
            // si toca la pantalla cuando el juego ha acabado, lo reiniciamos para volver a jugar
            gameOver = false
            puntuacion = 0
            self.speed = 1
            //Si voy creando nodes a la pantalla y no los elimino se van acumulando
            self.removeAllChildren()
            reiniciar()
        }
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let cuerpoA = contact.bodyA
        let cuerpoB = contact.bodyB
        
        print(cuerpoA.categoryBitMask)
        print(cuerpoB.categoryBitMask)
        
        print("TOCA LA PIEDRA")
        
        if (cuerpoA.categoryBitMask == tipoNodo.goku.rawValue &&
            cuerpoB.categoryBitMask == tipoNodo.object.rawValue)
            ||
            (cuerpoA.categoryBitMask == tipoNodo.object.rawValue &&
                cuerpoB.categoryBitMask == tipoNodo.goku.rawValue) {
            
            
            print("TOCA LA PIEDRA")
            
            puntuacion += 1
            labelPuntuacion.text = String("CcCcCc  Game Over")
            
            
        } else {
            // si no pasa por el hueco es porque ha tocado el suelo o una tubería
            // deberemos acabar el juego
            gameOver = true
            // Frenamos todo
            self.speed = 0
            // Paramos el timer
            timerPuntuacion.invalidate()
            labelPuntuacion.text = "Game Over"
            labelPuntuacion.text = String("CcCcCc  Game Over")
        }
        
    }

    func reiniciar() {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
