import SceneKit
import GameView
import GameScene

/// Class that conforms to the SCNSceneRendererDelegate and controls the behavior of the GameScene
public class GameController: NSObject {
    
    private let gameView: GameView
    private let gameScene: GameScene
    
    /// Initializes the GameController with the provided GameView containing a GameScene
    public init(gameView: GameView) {
        self.gameView = gameView
        self.gameScene = gameView.scene as! GameScene
        super.init()
        
        self.gameView.delegate = self
    }
}

extension GameController: SCNSceneRendererDelegate {
    public func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if gameScene.game.state == .inProgress {
            if time > gameScene.spawnTime {
                gameScene.launchFigure()
                
                let minimum: Float = gameScene.gameLevel == .feasible ? 0.7 : 0.2
                let maximum: Float = gameScene.gameLevel == .feasible ? 1.5 : 0.8
                gameScene.spawnTime = time + TimeInterval(Float.random(in: minimum...maximum))
            }
            
            if time > gameScene.targetFigureChangeTime {
                gameScene.changeTargetFigure()
                
                let minimum: Float = 4
                let maximum: Float = gameScene.gameLevel == .feasible ? 10 : 6
                gameScene.targetFigureChangeTime = time + TimeInterval(Float.random(in: minimum...maximum))
            }
            
            for node in gameScene.rootNode.childNodes {
                if node.name == "figure"  {
                    if node.presentation.position.y < -2 {
                        let hitFigureIdentifier =  node.geometry!.classForCoder
                        let targetFigureIdentifier = gameScene.currentTargetFigure.geometry.classForCoder
                        
                        if node.geometry?.materials.first?.diffuse.contents as! UIColor == gameScene.currentTargetFigure.color && hitFigureIdentifier == targetFigureIdentifier {
                            gameScene.game.remainingHp -= 1
                            gameScene.shakeScene()
                        }
                        
                        node.removeFromParentNode()
                    }
                }
            }
        }
    }
}
