class ChanelsService {
    let mockdata = {
        let chanel1 = Chanel(id: 1, name: "We Are Diamond", avatarImage: "defaultAvatar")
        let chanel2 = Chanel(id: 2, name: "SADEK Tuts", avatarImage: "defaultAvatar")
        let chanel3 = Chanel(id: 3, name: "Sony Pictures", avatarImage: "defaultAvatar")
        let chanel4 = Chanel(id: 4, name: "Amytrip", avatarImage: "defaultAvatar")
        let chanel5 = Chanel(id: 5, name: "miss daisy", avatarImage: "defaultAvatar")
        let chanel6 = Chanel(id: 6, name: "Dyna Sweek", avatarImage: "defaultAvatar")
        let chanel7 = Chanel(id: 7, name: "SkyeWei", avatarImage: "defaultAvatar")
        let chanel8 = Chanel(id: 8, name: "CGMeetup", avatarImage: "defaultAvatar")
        let chanel9 = Chanel(id: 9, name: "Keilidh", avatarImage: "defaultAvatar")
        let chanel10 = Chanel(id: 10, name: "Johnny B", avatarImage: "defaultAvatar")
        
        return [chanel1, chanel2, chanel3, chanel4, chanel5, chanel6, chanel7, chanel8, chanel9, chanel10]
    }
    
    func getAllChanels() -> [Chanel] {
        return mockdata()
    }

}
