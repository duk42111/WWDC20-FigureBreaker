
import SceneKit
import Extensions

/// Class responsible for handling the current target figure that the player needs to hit
public class TargetFigure {
    public var geometry: SCNGeometry
    public var color: UIColor {
        didSet {
            self.geometry.materials.first?.diffuse.contents = color
        }
    }
    
    /// Intialize the TargetFigure with the provided SCNGeometry and UIColor
    public init(_ geometry: SCNGeometry, _ color: UIColor) {
        self.geometry = geometry
        self.color = color
        self.geometry.materials.first?.diffuse.contents = color
    }
    
    /// Obtain an image resource name based on the geometry and color properties
    public func getImageName() -> String {
        var imageName = ""
        
        if geometry.isKind(of: SCNBox.self) {
            switch color {
            case .twinkleBlue:
                imageName = "box_twinkleBlue.png"
            case .flirtatious:
                imageName = "box_flirtatious.png"
            case .redPigment:
                imageName = "box_redPigment.png"
            case .maximumBlueGreen:
                imageName = "box_maximumBlueGreen.png"
            case .marineBlue:
                imageName = "box_marineBlue.png"
            default: break
            }
        } else if geometry.isKind(of: SCNSphere.self) {
            switch color {
            case .twinkleBlue:
                imageName = "sphere_twinkleBlue.png"
            case .flirtatious:
                imageName = "sphere_flirtatious.png"
            case .redPigment:
                imageName = "sphere_redPigment.png"
            case .maximumBlueGreen:
                imageName = "sphere_maximumBlueGreen.png"
            case .marineBlue:
                imageName = "sphere_marineBlue.png"
            default: break
            }
        } else if geometry.isKind(of: SCNPyramid.self) {
            switch color {
            case .twinkleBlue:
                imageName = "pyramid_twinkleBlue.png"
            case .flirtatious:
                imageName = "pyramid_flirtatious.png"
            case .redPigment:
                imageName = "pyramid_redPigment.png"
            case .maximumBlueGreen:
                imageName = "pyramid_maximumBlueGreen.png"
            case .marineBlue:
                imageName = "pyramid_marineBlue.png"
            default: break
            }
        } else if geometry.isKind(of: SCNCone.self) {
            switch color {
            case .twinkleBlue:
                imageName = "cone_twinkleBlue.png"
            case .flirtatious:
                imageName = "cone_flirtatious.png"
            case .redPigment:
                imageName = "cone_redPigment.png"
            case .maximumBlueGreen:
                imageName = "cone_maximumBlueGreen.png"
            case .marineBlue:
                imageName = "cone_marineBlue.png"
            default: break
            }
        } else if geometry.isKind(of: SCNTube.self) {
            switch color {
            case .twinkleBlue:
                imageName = "tube_twinkleBlue.png"
            case .flirtatious:
                imageName = "tube_flirtatious.png"
            case .redPigment:
                imageName = "tube_redPigment.png"
            case .maximumBlueGreen:
                imageName = "tube_maximumBlueGreen.png"
            case .marineBlue:
                imageName = "tube_marineBlue.png"
            default: break
            }
        } 
        
        return imageName
    }
}
