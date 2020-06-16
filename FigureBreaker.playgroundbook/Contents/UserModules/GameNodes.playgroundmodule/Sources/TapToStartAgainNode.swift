import SceneKit

/// SCNNode showing "Tap to start again" image
public class TapToStartAgainNode: SCNNode {
    public override init() {
        super.init()
        let plane = SCNPlane(width: 10, height: 2)
        self.geometry = plane
        self.position = SCNVector3(x: 0, y: 3, z: 0)
        self.name = "tapToStartAgain"
        self.geometry?.materials.first?.diffuse.contents = "tapToStartAgain.png"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
