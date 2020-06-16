import SceneKit
import GameScene
import Game

/// Base SCNView class for the game
public class GameView: SCNView {
    
    /// SCNScene where figures are spawned
    private var gameScene: GameScene!
    
    /// Tap gesture recognizer for changing game state. Changes the game state when in .readyToStart, .gameOver, .win states 
    private lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.addTarget(self, action: #selector(handleTap))
        return gestureRecognizer
    }()
    
    /// Pan gesture recognizer for hitting figures
    private lazy var panGestureRecognizer: UIPanGestureRecognizer = {
        let gestureRecognizer = UIPanGestureRecognizer()
        gestureRecognizer.addTarget(self, action: #selector(handlePan))
        return gestureRecognizer
    }()
    
    /// Initialize the GameView
    public init(gameScene: GameScene) {
        super.init(frame: .zero, options: nil)
        setupScene(gameScene)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Setup the scene and add gesture recognizers to the GameView
    private func setupScene(_ scene: GameScene) {
        self.gameScene = scene
        self.scene = gameScene
        self.autoenablesDefaultLighting = true
        self.gestureRecognizers = [tapGestureRecognizer, panGestureRecognizer]
        self.isPlaying = true
    }
    
    /// Detects when a pan gesture is performed. If a node was found at the location, call the handlePanForNode method of the GameScene
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        let location = sender.location(in: self)
        let hitResults = self.hitTest(location, options: nil)
        
        if let result = hitResults.first {
            gameScene.handlePanForNode(result.node)
        }
    }
    
    /// Detects when a tap gesture is performed. Offloads the game state changing logic to the GameScene 
    @objc func handleTap(sender: UITapGestureRecognizer) {
        gameScene.handleTap()
    }
    
}
