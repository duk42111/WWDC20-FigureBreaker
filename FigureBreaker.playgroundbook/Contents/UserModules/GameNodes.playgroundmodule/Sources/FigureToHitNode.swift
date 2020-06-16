import SceneKit

/// SCNNode displaying a colored target figure's title
public class FigureToHitNode: SCNNode {
    public override init() {
        super.init()
        let plane = SCNPlane(width: 6, height: 2)
        self.geometry = plane
        self.position = SCNVector3(x: 0, y: 10, z: 0)
        self.name = "figureToHit"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
