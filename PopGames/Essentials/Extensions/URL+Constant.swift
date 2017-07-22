import Foundation

extension URL {

    struct Twitch {
        private static var base = "https://api.twitch.tv"
        static var topGame: URL = URL(string: "\(base)/kraken/games/top")!
    }

}
