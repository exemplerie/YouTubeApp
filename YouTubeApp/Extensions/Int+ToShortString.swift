extension Int {
    func toShortString() -> String {
        let num = Double(self)
        
        switch num {
        case 1_000_000_000...:
            return String(format: "%.0fB", num / 1_000_000_000)
        case 1_000_000...:
            return String(format: "%.0fM", num / 1_000_000)
        case 1_000...:
            return String(format: "%.0fK", num / 1_000)
        default:
            return "\(self)"
        }
    }
}
