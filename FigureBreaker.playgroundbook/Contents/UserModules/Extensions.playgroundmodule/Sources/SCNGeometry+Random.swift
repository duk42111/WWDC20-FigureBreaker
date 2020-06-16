import SceneKit

/// SCNGeometry extension that generates a random SCNGeometry from three possible choices: SCNBox, SCNSphere, and SCNPyramid
public extension SCNGeometry {
    static func random() -> SCNGeometry {
        let allTypes = [
            SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.0),
            SCNSphere(radius: 0.5),
            SCNPyramid(width: 1.0, height: 1.0, length: 1.0)
        ]
        
        return allTypes.randomElement()!
    }
}
