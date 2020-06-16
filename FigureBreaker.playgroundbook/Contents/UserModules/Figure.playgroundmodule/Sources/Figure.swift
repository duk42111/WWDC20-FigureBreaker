
import Foundation

/// Enum representing three possible figures: box, sphere, and pyramid. Contains a static random() method for obtaining a random enum case
public enum Figure: CaseIterable {
    case box
    case sphere
    case pyramid
    
    public static func random() -> Figure {
        let randomFigure = Figure.allCases.randomElement()!
        return randomFigure
    }
}
