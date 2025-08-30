import UIKit

enum CustomFonts: String {
    case roboto = "Roboto-Regular"
}

struct FontBuilder {
    let font: CustomFonts
    let size: Double
    let weight: Double
    let color: UIColor
    let lineHeight: Double
    let verticalSpacing: Double
    
    init(font: CustomFonts, size: Double, weight: Double, color: UIColor = .black, lineHeight: Double = 1.0, verticalSpacing: Double = 0.0) {
        self.font = font
        self.size = size
        self.weight = weight
        self.color = color
        self.lineHeight = lineHeight
        self.verticalSpacing = verticalSpacing
    }
}

extension FontBuilder {
    static let tabBarTitles = FontBuilder(font: .roboto, size: 12, weight: 400)
    
    static let videoPreviewTitle = FontBuilder(font: .roboto, size: 14, weight: 500)
    static let videoExtraInfo = FontBuilder(font: .roboto, size: 12, weight: 500, color: .extraInfo)
    
    static let shortsPreviewTitle = FontBuilder(font: .roboto, size: 12, weight: 500, color: .white)
    static let shortsPreviewTitleExtraInfo = FontBuilder(font: .roboto, size: 10, weight: 500, color: .white)
    static let shortsTitle = FontBuilder(font: .roboto, size: 16, weight: 400, color: .white)
    static let shortsChanelTitle = FontBuilder(font: .roboto, size: 14, weight: 500, color: .white)
    static let shortsRating = FontBuilder(font: .roboto, size: 12, weight: 500, color: .white)
    
    static let exploreButton = FontBuilder(font: .roboto, size: 14, weight: 500)
    static let videoCategoryButton = FontBuilder(font: .roboto, size: 12, weight: 400)
}

extension FontBuilder {
    static func customFont(_ fontBuilder: FontBuilder) -> UIFont {
        let font = UIFont(name: fontBuilder.font.rawValue, size: fontBuilder.size)?.withWeight(UIFont.Weight(rawValue: fontBuilder.weight))

        return font ?? .systemFont(ofSize: fontBuilder.size)
    }
}

extension UIFont {
    func withWeight(_ weight: UIFont.Weight) -> UIFont {
        let newDescriptor = fontDescriptor.addingAttributes([.traits: [
            UIFontDescriptor.TraitKey.weight: weight]
                                                            ])
        return UIFont(descriptor: newDescriptor, size: pointSize)
    }
}
