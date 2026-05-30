import Foundation

enum Sport: String, CaseIterable {
    case basketball    = "Basketball"
    case football      = "American Football"
    case baseball      = "Baseball"
    case hockey        = "Ice Hockey"
    case golf          = "Golf"
    case tennis        = "Tennis"
    case lacrosse      = "Lacrosse"
    case rugby         = "Rugby"
    case swimming      = "Swimming"
    case trackField    = "Track & Field"
    case volleyball    = "Volleyball"

    var emoji: String {
        switch self {
        case .basketball: return "🏀"
        case .football:   return "🏈"
        case .baseball:   return "⚾"
        case .hockey:     return "🏒"
        case .golf:       return "⛳"
        case .tennis:     return "🎾"
        case .lacrosse:   return "🥍"
        case .rugby:      return "🏉"
        case .swimming:   return "🏊"
        case .trackField: return "🏃"
        case .volleyball: return "🏐"
        }
    }

    var isGolf: Bool { self == .golf }

    var positions: [String] {
        switch self {
        case .basketball:
            return ["Point Guard", "Shooting Guard", "Small Forward", "Power Forward", "Center"]
        case .football:
            return ["Quarterback", "Wide Receiver", "Running Back", "Tight End",
                    "Linebacker", "Cornerback", "Safety", "Offensive Lineman", "Defensive Lineman"]
        case .baseball:
            return ["Pitcher", "Catcher", "First Base", "Second Base",
                    "Shortstop", "Third Base", "Outfielder"]
        case .hockey:
            return ["Goalie", "Defenseman", "Center", "Left Wing", "Right Wing"]
        case .lacrosse:
            return ["Attack", "Midfielder", "Defense", "Goalie"]
        case .rugby:
            return ["Prop", "Hooker", "Lock", "Flanker", "Number 8",
                    "Scrum-half", "Fly-half", "Wing", "Centre", "Fullback"]
        case .volleyball:
            return ["Setter", "Outside Hitter", "Middle Blocker", "Libero", "Opposite Hitter"]
        case .tennis:
            return ["Serve & Volley", "Aggressive Baseliner", "Defensive Baseliner", "All-Court Player"]
        case .swimming:
            return ["Sprinter (50–100m)", "Middle Distance (200–400m)", "Distance (800m+)", "Individual Medley"]
        case .trackField:
            return ["Sprinter", "Distance Runner", "Jumper", "Thrower / Shot Put"]
        case .golf:
            return []
        }
    }
}

enum GolferType: String, CaseIterable {
    case powerHitter = "Power Hitter"
    case precision   = "Precision Shotmaker"
    case shortGame   = "Short Game Specialist"
    case allAround   = "All-Around"

    var emoji: String {
        switch self {
        case .powerHitter: return "💪"
        case .precision:   return "🎯"
        case .shortGame:   return "🪄"
        case .allAround:   return "⚖️"
        }
    }

    var blurb: String {
        switch self {
        case .powerHitter: return "Muscle it long, attack aggressively"
        case .precision:   return "Surgical accuracy, hit every fairway"
        case .shortGame:   return "Scramble and putt your way to low scores"
        case .allAround:   return "No glaring weaknesses, solid everywhere"
        }
    }
}
