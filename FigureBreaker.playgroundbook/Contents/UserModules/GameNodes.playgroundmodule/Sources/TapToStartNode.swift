import SceneKit

/// Node showing "Tap anywhere to start" image
public class TapToStartNode: SCNNode {
    public override init() {
        super.init()
        let plane = SCNPlane(width: 15, height: 2)
        self.geometry = plane
        self.position = SCNVector3(x: 0, y: 5, z: 0)
        self.name = "tapToStart"
        self.geometry?.materials.first?.diffuse.contents = "tapToStart.png"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
