import UIKit

/// Extension that generates a random UIColor from the selected array of colors
public extension UIColor {
    public static let twinkleBlue = UIColor(hex: "#D1D8E0")!
    public static let flirtatious = UIColor(hex: "#FED330")!
    public static let maximumBlueGreen = UIColor(hex: "#2BCBBA")!
    public static let redPigment = UIColor(hex: "#EA2027")!
    public static let marineBlue = UIColor(hex: "#0652DD")!
    
    static func random() -> UIColor {
        let allColors = [
            UIColor.twinkleBlue,
            UIColor.flirtatious,
            UIColor.maximumBlueGreen,
            UIColor.redPigment,
            UIColor.marineBlue
        ]
        return allColors.randomElement()!
    }
}
