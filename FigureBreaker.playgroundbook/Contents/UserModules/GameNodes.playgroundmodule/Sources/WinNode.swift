import SceneKit

/// SCNNode showing "You won!" image
public class WinNode: SCNNode {
    public override init() {
        super.init()
        let plane = SCNPlane(width: 10, height: 2)
        self.geometry = plane
        self.position = SCNVector3(x: 0, y: 5, z: 0)
        self.name = "win"
        self.geometry?.materials.first?.diffuse.contents = #imageLiteral(resourceName: "won.png")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
