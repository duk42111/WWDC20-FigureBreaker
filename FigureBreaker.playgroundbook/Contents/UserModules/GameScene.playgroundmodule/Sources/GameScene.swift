import Combine
import SceneKit
import GameNodes
import Game
import Figure
import Extensions

/// SCNScene that displays figures and relevant SCNNodes for the game 
public class GameScene: SCNScene {
    
    private var cancellables = Set<AnyCancellable>()
    public let gameLevel: GameLevel
    
    /// Class responsible for having the state of the game and the progress of a player
    public lazy var game: Game = { return Game(gameLevel: self.gameLevel) }()
    
    /// Current target figure that the player needs to hit
    public var currentTargetFigure: TargetFigure!
    
    public var spawnTime: TimeInterval = 0
    
    /// TimeInterval handling how many seconds are left for another for a target figure to change
    public var targetFigureChangeTime: TimeInterval = 0
    
    /// SCNNode showing the "Tap anywhere to start" image
    private let tapToStartNode: SCNNode = TapToStartNode()
    
    /// SCNNode showing the "Game over" image
    private let gameOverNode: SCNNode = GameOverNode()
    
    /// SCNNode showing the "You won!" image
    private let winNode: SCNNode = WinNode()
    
    /// SCNNode showing the "Tap to start again" image
    private let tapToStartAgainNode: SCNNode = TapToStartAgainNode()
    
    /// SCNNode displaying a colored target figure's title
    private let figureToHitNode: SCNNode = FigureToHitNode()
    
    /// SCNNode that displays the remaining HP of the player and their score
    private lazy var progressNode: SCNNode = { 
        return ProgressNode(game: self.game)
    }()
    
    /// Initializes the GameScene with the provided GameLevel
    public init(gameLevel: GameLevel) {
        self.gameLevel = gameLevel
        super.init()
        
        setupBackground()
        setupCamera()
        playBackgroundMusic()
        
        observeForGameStateChange()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Setups the background image of the GameScene
    private func setupBackground() {
        self.background.contents = UIImage(named: "background.png")
    }
    
    /// Setups the camera node and adds it to the rootNode of the GameScene
    private func setupCamera() {
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(0, 5, 12)
        cameraNode.name = "camera"
        self.rootNode.addChildNode(cameraNode)
    }
    
    /// Creates and launches a random figure into the GameScene with a specified force
    public func launchFigure() {
        let figure = FigureProvider.getRandomFigure()
        
        let randomX = Float.random(in: -2...2)
        let force = SCNVector3(x: randomX, y: 15, z: 0)
        let position = SCNVector3(x: 0.05, y: 0.05, z: 0.05)
        figure.physicsBody?.applyForce(force, at: position, asImpulse: true)
        
        self.rootNode.addChildNode(figure)
        
        playFigureLaunchSound()
    }
    
    /// Reacts for tap gesture from the SCNView and changes the state of the game accordingly
    public func handleTap() {
        switch self.game.state {
        case .readyToStart:
            // When initial tap occurs, setups the GameScene for the .inProgress game state
            self.game.state = .inProgress
        case .win, .gameOver:
            // When tapped, brings the state of the game back to .inProgress and setups the GameScene for that state
            self.game.state = .inProgress
            self.changeTargetFigure()
        case .inProgress: break
        }
    }
    
    /// Reacts for the pan gesture from the SCNView and removes a figure if it was hit. Changes the Game's remainingHp or currentScore properties accordingly
    public func handlePanForNode(_ node: SCNNode) {
        if node.name == "figure" {
            playFigureHitSound()
            
            let hitFigureIdentifier =  node.geometry!.classForCoder
            let targetFigureIdentifier = currentTargetFigure.geometry.classForCoder
            
            if node.geometry?.materials.first?.diffuse.contents as! UIColor == currentTargetFigure.color && hitFigureIdentifier == targetFigureIdentifier {
                self.game.currentScore += 1
            } else {
                shakeScene()
                self.game.remainingHp -= 1
            }
            
            node.removeFromParentNode()
        }
    }
    
    /// Observes for changes in state of the game and setups the GameScene with relevant nodes
    private func observeForGameStateChange() {
        game.$state
            .sink { [weak self] (state) in
                guard let self = self else { return }
                
                self.removeAllNodesExceptCamera()
                
                switch state {
                case .readyToStart:
                    self.rootNode.addChildNode(self.tapToStartNode)
                case .inProgress:
                    self.progressNode.position = SCNVector3(0.0, 11.0, 0.0)
                    self.rootNode.addChildNode(self.progressNode)
                case .gameOver:
                    self.rootNode.addChildNode(self.gameOverNode)
                    self.rootNode.addChildNode(self.tapToStartAgainNode)
                case .win:
                    self.rootNode.addChildNode(self.winNode)
                    self.rootNode.addChildNode(self.tapToStartAgainNode)
                }
        }.store(in: &cancellables)
    }
    
    /// Switches to a different random target figure that the player needs to hit
    public func changeTargetFigure() {
        let geometry = SCNGeometry.random()
        let color = UIColor.random()
        
        let newTargetFigure = TargetFigure(geometry, color)
        
        figureToHitNode.geometry?.materials.first?.diffuse.contents = newTargetFigure.getImageName()
        
        currentTargetFigure = newTargetFigure
        if figureToHitNode.parent == nil {
            self.rootNode.addChildNode(figureToHitNode)
        }
    }
    
    /// Loops through all nodes in the GameScene and removes all of them except the camera
    private func removeAllNodesExceptCamera() {
        for node in self.rootNode.childNodes {
            if node.name != "camera" {
                node.removeFromParentNode()
            }
        }
    }
    
    /// Plays background music in a loop
    private func playBackgroundMusic() {
        let audioSource = SCNAudioSource(fileNamed: "backgroundMusic.mp3")!
        audioSource.volume = 0.3
        let playSoundAction = SCNAction.playAudio(audioSource, waitForCompletion: true)
        let loopAction = SCNAction.repeatForever(playSoundAction)
        self.rootNode.runAction(loopAction)
    }
    
    /// Plays a figure's launch sound
    private func playFigureLaunchSound() {
        let audioSource = SCNAudioSource(fileNamed: "figureLaunchSound.mp3")!
        audioSource.volume = 0.3
        self.rootNode.runAction(.playAudio(audioSource, waitForCompletion: true))
    }
    
    /// Plays a sound when a figure was hit
    private func playFigureHitSound() {
        let audioSource = SCNAudioSource(fileNamed: "figureHitSound.mp3")!
        audioSource.volume = 0.8
        self.rootNode.runAction(.playAudio(audioSource, waitForCompletion: false))
    }
    
    // "Shakes" the GameScene's camera node when either an incorrect figure was hit or the target figure was missed
    public func shakeScene() {
        let left = SCNAction.move(by: SCNVector3(x: -0.2, y: 0.0, z: 0.0), duration: 0.05)
        let right = SCNAction.move(by: SCNVector3(x: 0.2, y: 0.0, z: 0.0), duration: 0.05)

        self.rootNode.childNode(withName: "camera", recursively: true)?.runAction(SCNAction.sequence(
                    [left, right, left, right]))
    }
}
