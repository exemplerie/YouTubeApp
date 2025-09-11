import Foundation

enum VideoCategory: String, CaseIterable {
    case mixes = "Mixes"
    case music = "Music"
    case graphic = "Graphic"
    case animation = "Animation"
}

struct FullLengthVideo: Hashable {
    let id: String
    let name: String
    let image: String
    let chanel: Chanel
    let views: Int
    let uploadedAt: Date
    let category: VideoCategory
}
