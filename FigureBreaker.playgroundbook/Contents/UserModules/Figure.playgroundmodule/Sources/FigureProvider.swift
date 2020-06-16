import SceneKit
import Figure
import Extensions

/// FigureProvider is responsible for constructing and returning an individual figure and attaching to it a particle system
public class FigureProvider {
    private init() {}
    
    /// Generates a random figure
    public static func getRandomFigure() -> SCNNode {
        var geometry: SCNGeometry
        switch Figure.random() {
        case .box:
            geometry = SCNBox(width: 1.0, 
                              height: 1.0, 
                              length: 1.0, 
                              chamferRadius: 0.0)
        case .sphere:
            geometry = SCNSphere(radius: 0.5)
        case .pyramid:
            geometry = SCNPyramid(width: 1.0, 
                                  height: 1.0, 
                                  length: 1.0)
        }
        
        let color = UIColor.random()
        geometry.materials.first?.diffuse.contents = color
        let figureNode = SCNNode(geometry: geometry)
        figureNode.name = "figure"
        figureNode.position = SCNVector3(x: Float.random(in: -4...4), y: 0, z: 0) 
        figureNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        
        let trailSystem = SCNParticleSystem(named: "Path.scnp", inDirectory: nil)!
        trailSystem.particleColor = color
        trailSystem.emitterShape = geometry
        
        figureNode.addParticleSystem(trailSystem)
        return figureNode
    }
}
