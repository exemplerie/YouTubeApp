class ShortsVideoService {
    
    private let mockData = {
        let chanels = ChanelsService().getAllChanels()
        
        return [
            ShortsVideo(name: "DIY Toys | Satisfying And Relaxing | SADEK Tuts Tiktok Compition | Fidget Trading #SADEK #Shorts tiktok", image: "shorts_1", chanel: chanels[1], views: 24004583, likes: 99548, commentsCount: 36503),
            ShortsVideo(name: "Ranking the Funniest Filter Challenge", image: "shorts_2", chanel: chanels[0], views: 99562, likes: 54923, commentsCount: 11254),
            ShortsVideo(name: "Best EMOJI? | TikTok Mashup 2025", image: "shorts_3", chanel: chanels[2], views: 100431, likes: 59304, commentsCount: 18830),
            ShortsVideo(name: "Ice-cream Machine in Japan.", image: "shorts_4", chanel: chanels[3], views: 1204583, likes: 99548, commentsCount: 36503),
            ShortsVideo(name: "Beth Harmon’s Genius Move! 🧠🔥 Queen’s Gambit – The Ultimate Chess Mastery Unleashed ♟️💥", image: "shorts_5", chanel: chanels[4], views: 83467, likes: 17332, commentsCount: 1262),
            ShortsVideo(name: "trying the WORLD'S SMALLEST curling iron.", image: "shorts_6", chanel: chanels[5], views: 99562, likes: 54923, commentsCount: 11254),
            ShortsVideo(name: "Why don't videogame mirrors work?", image: "shorts_7", chanel: chanels[6], views: 957364, likes: 512119, commentsCount: 432711),
            ShortsVideo(name: "7 Useful 3D prints", image: "shorts_8", chanel: chanels[7], views: 1204583, likes: 99548, commentsCount: 36503),
            ShortsVideo(name: "Oreo Lasagne from @fitwaffleKitchen #shorts", image: "shorts_9", chanel: chanels[8], views: 714325, likes: 212345, commentsCount: 87560),
            ShortsVideo(name: "Italians try VIRAL WATERMELON HACK", image: "shorts_10", chanel: chanels[9], views: 83467, likes: 17332, commentsCount: 1262),
        ]
    }()
    
    func getShortsVideos() -> [ShortsVideo] {
        return Array(repeating: mockData, count: 5).flatMap { $0 }.shuffled()
    }
}
