import UIKit


enum FontFamily: String {
    case roboto = "Roboto"
}

extension FontFamily {
    func fontName(for weight: Int) -> String {
        switch self {
        case .roboto:
            switch weight {
            case 100: return "Roboto-Thin"
            case 200: return "Roboto-ExtraLight"
            case 300: return "Roboto-Light"
            case 400: return "Roboto-Regular"
            case 500: return "Roboto-Medium"
            case 600: return "Roboto-SemiBold"
            case 700: return "Roboto-Bold"
            case 800: return "Roboto-ExtraBold"
            case 900: return "Roboto-Black"
            default: return "Roboto-Regular"
            }
        }
    }
}

struct FontBuilder {
    let family: FontFamily
    let size: Double
    let weight: Int
    let lineHeight: Double
    let verticalSpacing: Double
    
    init(family: FontFamily, size: Double, weight: Int, lineHeight: Double = 1.0, verticalSpacing: Double = 0.0) {
        self.family = family
        self.size = size
        self.weight = weight
        self.lineHeight = lineHeight
        self.verticalSpacing = verticalSpacing
    }
}

extension FontBuilder {
    static let tabBarTitles = FontBuilder(family: .roboto, size: 12, weight: 400)
    
    static let videoPreviewTitle = FontBuilder(family: .roboto, size: 15.5, weight: 500)
    static let videoExtraInfo = FontBuilder(family: .roboto, size: 13, weight: 500)
    
    static let shortsBannerTitle = FontBuilder(family: .roboto, size: 16, weight: 500)
    static let shortsBannerTitleBeta = FontBuilder(family: .roboto, size: 10, weight: 400)
    
    static let shortsPreviewTitle = FontBuilder(family: .roboto, size: 13.5, weight: 500)
    static let shortsPreviewTitleExtraInfo = FontBuilder(family: .roboto, size: 11.5, weight: 500)
    static let shortsTitle = FontBuilder(family: .roboto, size: 18, weight: 400)
    static let shortsChanelTitle = FontBuilder(family: .roboto, size: 16, weight: 500)
    static let shortsRating = FontBuilder(family: .roboto, size: 12, weight: 500)
    static let shortsSubscribeButton = FontBuilder(family: .roboto, size: 15.5, weight: 500)
    
    static let exploreButton = FontBuilder(family: .roboto, size: 16, weight: 500)
    static let videoCategoryButton = FontBuilder(family: .roboto, size: 14, weight: 400)
}

extension FontBuilder {
    static func customFont(_ fontBuilder: FontBuilder) -> UIFont {
        let fontName = fontBuilder.family.fontName(for: fontBuilder.weight)

        return UIFont(name: fontName, size: fontBuilder.size) ?? .systemFont(ofSize: fontBuilder.size, weight: UIFont.Weight(rawValue: CGFloat(fontBuilder.weight)))
    }
}
