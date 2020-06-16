import Combine
import SpriteKit
import SceneKit
import Game

/// SCNNode that displays the remaining HP of the player and their score
public class ProgressNode: SCNNode {
    
    private var cancellables = Set<AnyCancellable>() 
    private let game: Game
    
    /// SKLabelNode showing current hp and score
    private var progressLabelNode = SKLabelNode(fontNamed: "Avenir-Heavy")
    
    ///String consisting of hearts to represent HP
    private var hpString = ""
    
    ///String that represents score progress of the game
    private var scoreString = ""
    
    /// Intialize the ProgressNode
    public init(game: Game) {
        self.game = game
        super.init()
        
        setupNode()
        
        observeHp()
        observeScore()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Setup the ProgressNode by assigning it an SCNGeometry consisting of an SKLabelNode
    private func setupNode() {
        let skScene = SKScene(size: CGSize(width: 500, height: 100))
        skScene.backgroundColor = UIColor(white: 0.0, alpha: 0.0)
        
        progressLabelNode.fontSize = 48
        progressLabelNode.position.y = 50
        progressLabelNode.position.x = 250
        
        skScene.addChild(progressLabelNode)
        
        let plane = SCNPlane(width: 5, height: 1)
        let material = SCNMaterial()
        material.lightingModel = .constant
        material.isDoubleSided = true
        material.diffuse.contents = skScene
        plane.materials = [material]
        
        self.geometry = plane
        self.name = "progress"
        self.rotation = SCNVector4(x: 1, y: 0, z: 0, w: Float.pi)
    }
    
    /// Observe the @Published remainingHp property of the Game and update the progress label node when a new value is received
    private func observeHp() {
        game.$remainingHp
            .sink { [weak self] (remainingHp) in
                guard let self = self else { return }
                
                switch remainingHp {
                case 3:
                    self.hpString = "💚💚💚"
                case 2:
                    self.hpString = "🧡🧡"
                case 1:
                    self.hpString = "♥️"
                case 0:
                    self.hpString = ""
                default: break
                }
                
                if self.hpString.isEmpty {
                    self.progressLabelNode.text = self.scoreString
                } else {
                    self.progressLabelNode.text = "\(self.hpString), \(self.scoreString)"
                }
        }.store(in: &cancellables)
    }
    
    /// Observe the @Published currentScore property of the Game and update the progress label node when a new value is received
    private func observeScore() {
        game.$currentScore
            .sink { [weak self] (currentScore) in
                guard let self = self else { return }
                
                self.scoreString = "\(currentScore) / \(self.game.goalScore)"
                
                if self.hpString.isEmpty {
                    self.progressLabelNode.text = self.scoreString
                } else {
                    self.progressLabelNode.text = "\(self.hpString), \(self.scoreString)"
                }
        }.store(in: &cancellables)
    }
}
