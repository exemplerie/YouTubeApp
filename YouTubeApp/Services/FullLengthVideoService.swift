import Foundation
class FullLengthVideoService {
    private lazy var mockData = {
        let chanels = ChanelsService().getAllChanels()
        
        return [
            FullLengthVideo(id: "0", name: "The Beauty of Existence - Heart Touching Nasheed", image: "video_1", chanel: chanels[0], views: 19210251, uploadedAt: Date(), category: .mixes),
            FullLengthVideo(id: "1", name: "summer lofi radio ☀️ chill beats for sunny days", image: "video_2", chanel: chanels[1], views: 10100, uploadedAt: Date(), category: .music),
            FullLengthVideo(id: "2", name: "Graphic Design Basics | FREE COURSE", image: "video_3", chanel: chanels[2], views: 102405, uploadedAt: Date(), category: .graphic),
            FullLengthVideo(id: "3", name: "Top Hits 2025 ~ Summer Playlist 2025 ~ Top Songs 2025 Trending Music 🎶🎧", image: "video_4", chanel: chanels[3], views: 46883, uploadedAt: Date(), category: .music),
            FullLengthVideo(id: "4", name: "A Magical Firefly Who Saves the Forest Every Night", image: "video_5", chanel: chanels[4], views: 223563, uploadedAt: Date(), category: .animation),
            FullLengthVideo(id: "5", name: "Setting Bleeds & Margins for Print: Photoshop and InDesign Guide", image: "video_6", chanel: chanels[5], views: 572991, uploadedAt: Date(), category: .graphic),
            FullLengthVideo(id: "6", name: "Tom & Jerry | A Bit of Fresh Air! | Classic Cartoon Compilation | @WB Kids", image: "video_7", chanel: chanels[6], views: 11540, uploadedAt: Date(), category: .animation),
            FullLengthVideo(id: "7", name: "Morning Vibes Playlist ☕ Feel Good Music to Lift Your Mood", image: "video_8", chanel: chanels[7], views: 5614375, uploadedAt: Date(), category: .music),
            FullLengthVideo(id: "8", name: "Животные мира 4K - Замечательный фильм о дикой природе", image: "video_9", chanel: chanels[8], views: 11540, uploadedAt: Date(), category: .mixes),
            FullLengthVideo(id: "9", name: "Master Adobe Illustrator: 17 Pro Tips For Graphic Designers", image: "video_10", chanel: chanels[9], views: 25421994, uploadedAt: Date(), category: .graphic)
        ]
    }()
    
    func getAllFullLengthVideos() -> [FullLengthVideo] {
        return Array(repeating: mockData, count: 5).flatMap { $0 }.shuffled()
//        return mockData
    }
    
    func getFullLengthVideosByCategory(_ category: VideoCategory) -> [FullLengthVideo] {
        return mockData.filter { $0.category == category }
    }
}
