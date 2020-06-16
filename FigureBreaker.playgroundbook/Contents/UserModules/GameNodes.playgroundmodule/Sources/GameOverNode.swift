import SceneKit

/// Node showing "Game over" image
public class GameOverNode: SCNNode {
    public override init() {
        super.init()
        let plane = SCNPlane(width: 10, height: 2)
        self.geometry = plane
        self.position = SCNVector3(x: 0, y: 5, z: 0)
        self.name = "gameOver"
        self.geometry?.materials.first?.diffuse.contents = "gameOver.png"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
