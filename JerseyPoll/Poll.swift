import Foundation

struct JerseyOption: Codable {
    let id: String
    let name: String
    var votes: Int
}

struct JerseyPoll: Codable {
    var options: [JerseyOption]

    var totalVotes: Int { options.reduce(0) { $0 + $1.votes } }

    static func defaultPoll() -> JerseyPoll {
        JerseyPoll(options: [
            JerseyOption(id: "1", name: "Classic White", votes: 0),
            JerseyOption(id: "2", name: "Bold Red", votes: 0),
            JerseyOption(id: "3", name: "Navy Blue", votes: 0),
            JerseyOption(id: "4", name: "Black & Gold", votes: 0),
        ])
    }

    func toURLQueryItem() -> URLQueryItem? {
        guard let data = try? JSONEncoder().encode(self),
              let string = String(data: data, encoding: .utf8) else { return nil }
        return URLQueryItem(name: "poll", value: string)
    }

    static func from(url: URL) -> JerseyPoll? {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let pollValue = components.queryItems?.first(where: { $0.name == "poll" })?.value,
              let data = pollValue.data(using: .utf8),
              let poll = try? JSONDecoder().decode(JerseyPoll.self, from: data)
        else { return nil }
        return poll
    }
}
