import Foundation

enum ArchetypeEngine {

    static func archetype(sport: Sport, position: String) -> SoccerArchetype {
        switch sport {
        case .basketball:  return basketball(position)
        case .football:    return americanFootball(position)
        case .baseball:    return baseball(position)
        case .hockey:      return hockey(position)
        case .lacrosse:    return lacrosse(position)
        case .rugby:       return rugby(position)
        case .volleyball:  return volleyball(position)
        case .tennis:      return tennis(position)
        case .swimming:    return swimming(position)
        case .trackField:  return trackField(position)
        case .golf:        return fallback()
        }
    }

    static func archetypeForGolf(handicap: Int, type: GolferType) -> SoccerArchetype {
        let tier: Int = handicap <= 5 ? 0 : handicap <= 15 ? 1 : 2
        switch (type, tier) {
        case (.powerHitter, 0):
            return make("Striker", "ST", "The Aggressive Forward",
                "Low handicap + raw power = a relentless, goal-hungry striker. You go for broke every time — big, physical, and clinical. The box is your kingdom.",
                ["Aggressive", "Physical", "Clinical", "Goal-hungry", "Big-game mentality"],
                "Cristiano Ronaldo", "#E63946")
        case (.powerHitter, 1):
            return make("Striker", "ST", "The Physical Focal Point",
                "Power but still developing precision — you're a target man who holds the ball, wins headers, and makes defenders miserable. Your presence alone changes the game.",
                ["Aerial threat", "Hold-up play", "Physical", "Link play", "Work rate"],
                "Zlatan Ibrahimović", "#E63946")
        case (.powerHitter, _):
            return make("Center Back", "CB", "The Physical Anchor",
                "Power is your gift. As a center back, your physicality is a weapon — you dominate aerially and intimidate anyone who tries to run at you.",
                ["Dominant", "Physical", "Aerial power", "Commanding", "Resilient"],
                "Virgil van Dijk", "#2D6A4F")

        case (.precision, 0):
            return make("Central Midfielder", "CM", "The Metronomic Playmaker",
                "Elite precision + low handicap = the player who never wastes a pass. You see angles nobody else does and execute flawlessly. The game slows down for you.",
                ["Vision", "Passing range", "Decision-making", "Composure", "Intelligence"],
                "Xavi Hernández", "#457B9D")
        case (.precision, 1):
            return make("Central Midfielder", "CM", "The Technical Engine",
                "You have the precision to pick the right pass and control the tempo. The team's brain in midfield — always finds the solution.",
                ["Technique", "Ball retention", "Positioning", "Work rate", "Smart"],
                "Thiago Alcântara", "#457B9D")
        case (.precision, _):
            return make("Full Back", "RB/LB", "The Reliable Contributor",
                "Great positional awareness and decision-making. As a full back you never take unnecessary risks and always find the right option.",
                ["Disciplined", "Positional IQ", "Decision-making", "Solid", "Team-first"],
                "Philipp Lahm", "#2D6A4F")

        case (.shortGame, 0):
            return make("Attacking Midfielder", "CAM", "The Technical Magician",
                "Elite short game at a low handicap = close-control genius. Creative in tight spaces, unpredictable, and makes defenders look silly. The ultimate #10.",
                ["Close control", "Creativity", "Vision", "Composure", "Unpredictable"],
                "Lionel Messi", "#F4A261")
        case (.shortGame, 1):
            return make("Defensive Midfielder", "CDM", "The Gritty Grinder",
                "You make up for a lack of raw range with relentless work rate and smart play in tight spaces. Always in the right place — the engine room of the team.",
                ["Work rate", "Grit", "Ball-winning", "Smart use of space", "Adaptable"],
                "N'Golo Kanté", "#457B9D")
        case (.shortGame, _):
            return make("Defensive Midfielder", "CDM", "The Scrappy Workhorse",
                "High handicap but a sharp short game means you hustle and scrap. Effort and positioning make you invaluable even without elite physical tools.",
                ["Hustle", "Positioning", "Ball-winning", "Tenacious", "Consistent"],
                "Marcos Llorente", "#457B9D")

        case (.allAround, 0):
            return make("Central Midfielder", "CM", "The Complete Player",
                "Low handicap all-around golfer = the most complete midfielder on the pitch. No weakness. You can defend, create, and score. Every manager's dream.",
                ["Complete", "Versatile", "Consistent", "Clutch", "Leadership"],
                "Luka Modrić", "#457B9D")
        case (.allAround, 1):
            return make("Full Back", "RB/LB", "The Modern Wing-Back",
                "Well-rounded mid-handicapper = a full back who can do it all. Defend, overlap, cross, track back. Not flashy, but absolutely essential.",
                ["Two-way play", "Stamina", "Reliable", "Positioning", "Contributing"],
                "Dani Carvajal", "#2D6A4F")
        case (.allAround, _):
            return make("Center Back", "CB", "The Steady Defender",
                "All-around but still developing. As a center back, you're the foundation — reliable, consistent, and a calming presence at the back.",
                ["Reliable", "Positional", "Team player", "Reads the game", "Composed"],
                "Mats Hummels", "#2D6A4F")
        }
    }

    // MARK: - Sport mappings

    private static func basketball(_ pos: String) -> SoccerArchetype {
        switch pos {
        case "Point Guard":
            return make("Central Midfielder", "CM", "The Orchestrator",
                "Point guards run the offense, make others better, and control tempo — exactly what a central midfielder does. Your vision and decision-making define the team's rhythm.",
                ["Vision", "Distribution", "Leadership", "IQ", "Composure under pressure"],
                "Kevin De Bruyne", "#457B9D")
        case "Shooting Guard":
            return make("Winger", "RW/LW", "The Inverted Creator",
                "Shooting guards combine scoring instinct with athletic creation. You're a modern inverted winger who cuts inside, beats defenders, and shoots with purpose.",
                ["Scoring instinct", "Athleticism", "Cutting runs", "Clutch", "Dribbling"],
                "Arjen Robben", "#E63946")
        case "Small Forward":
            return make("Attacking Midfielder", "CAM", "The Versatile Threat",
                "Small forwards are the most versatile players on the court — athletic, mobile, and dangerous. You're an attacking midfielder who contributes in every phase.",
                ["Versatility", "Athleticism", "Goal threat", "Work rate", "Two-way"],
                "Kaká", "#F4A261")
        case "Power Forward":
            return make("Striker", "ST", "The Physical Target Man",
                "Power forwards are dominant, physical, and make life miserable for opponents. As a target man striker you hold the ball, win headers, and bring others into play.",
                ["Physicality", "Aerial ability", "Hold-up play", "Strength", "Presence"],
                "Didier Drogba", "#E63946")
        default: // Center
            return make("Center Back", "CB", "The Dominant Organizer",
                "Centers rule their area, protect the paint, and command teammates — just like an elite center back. You're aerial, physical, and authoritative at the back.",
                ["Aerial dominance", "Strength", "Reading the game", "Leadership", "Communication"],
                "Virgil van Dijk", "#2D6A4F")
        }
    }

    private static func americanFootball(_ pos: String) -> SoccerArchetype {
        switch pos {
        case "Quarterback":
            return make("Attacking Midfielder", "CAM", "The #10 General",
                "QBs read defenses, make split-second decisions, and elevate everyone around them. As an attacking midfielder you're the fulcrum — reading the game and unlocking defenses.",
                ["Vision", "Leadership", "Decision-making", "Execution under pressure", "Clutch"],
                "Luka Modrić", "#F4A261")
        case "Wide Receiver":
            return make("Winger", "RW/LW", "The Explosive Speedster",
                "WRs live on the edge, run precise routes, and turn on the afterburners. As a winger, your pace and timing off the ball make you a constant danger on the flank.",
                ["Pace", "Timing", "Concentration", "Runs in behind", "Big-play ability"],
                "Leroy Sané", "#E63946")
        case "Running Back":
            return make("Striker", "ST", "The Powerful Finisher",
                "Running backs burst through gaps, break tackles, and find the end zone. Your explosive first step, physicality, and finishing instinct make you a nightmare to contain.",
                ["Burst", "Elusiveness", "Physicality", "Finishing", "Contact balance"],
                "Romelu Lukaku", "#E63946")
        case "Tight End":
            return make("Striker", "ST", "The Aerial Target Man",
                "Tight ends are big, physical, and a reliable outlet. You're the towering striker who wins headers, shields the ball, and is a constant aerial threat in the box.",
                ["Size", "Aerial threat", "First touch", "Link play", "Red-zone presence"],
                "Olivier Giroud", "#E63946")
        case "Linebacker":
            return make("Defensive Midfielder", "CDM", "The Destroyer",
                "Linebackers read plays, make tackles, and patrol their zone. As a defensive midfielder, you're the shield in front of the back four — breaking up attacks and winning the ball.",
                ["Tackling", "Reading the game", "Physical", "Leadership", "Ball-winning"],
                "N'Golo Kanté", "#457B9D")
        case "Cornerback":
            return make("Full Back", "RB/LB", "The Lockdown Full Back",
                "Corners use speed and instinct to shut down elite receivers. As a full back, your 1v1 defending and athleticism make wingers regret facing you.",
                ["Speed", "1v1 defending", "Athleticism", "Positioning", "Competitive"],
                "Trent Alexander-Arnold", "#2D6A4F")
        case "Safety":
            return make("Goalkeeper", "GK", "The Sweeper Keeper",
                "Safeties patrol deep zones, read the offense, and are the last line. As a sweeper keeper you read the game brilliantly and command your area with authority.",
                ["Reading the game", "Positioning", "Communication", "Reflexes", "Sweeping"],
                "Manuel Neuer", "#6D6875")
        default: // OL / DL
            return make("Center Back", "CB", "The Brick Wall",
                "Linemen are physical, disciplined, and do the unglamorous work that wins games. As a center back, you're a wall — dominant in the air, hard to beat on the ground.",
                ["Physical dominance", "Strength", "Positional discipline", "Aerial", "Team-first"],
                "John Terry", "#2D6A4F")
        }
    }

    private static func baseball(_ pos: String) -> SoccerArchetype {
        switch pos {
        case "Pitcher":
            return make("Goalkeeper", "GK", "The Clutch Shot Stopper",
                "Pitchers have ice in their veins, elite arm strength, and thrive in 1v1 moments under pressure. As a goalkeeper you're calm when it matters most — a match-winner.",
                ["Mental toughness", "Clutch", "1v1 elite", "Distribution", "Composure"],
                "Gianluigi Buffon", "#6D6875")
        case "Catcher":
            return make("Center Back", "CB", "The Field General",
                "Catchers see the whole game, call the plays, and organize from the back. As a center back your leadership and game-reading make you the heartbeat of the defense.",
                ["Game-reading", "Organizing", "Leadership", "Communication", "Defensive IQ"],
                "Sergio Ramos", "#2D6A4F")
        case "Shortstop":
            return make("Central Midfielder", "CM", "The Dynamic Engine",
                "Shortstops have elite range, athleticism, and handle every situation cleanly. As a central midfielder you cover every blade of grass and make the game look easy.",
                ["Range", "Athleticism", "Quick thinking", "Versatility", "Consistency"],
                "Sergio Busquets", "#457B9D")
        case "Second Base":
            return make("Defensive Midfielder", "CDM", "The Interceptor",
                "Second basemen are quick, positionally smart, and always in the right spot. Your anticipation and positioning cut out attacks before they develop.",
                ["Anticipation", "Positioning", "Quick decisions", "Grit", "Work rate"],
                "Casemiro", "#457B9D")
        case "First Base":
            return make("Striker", "ST", "The Clinical Poacher",
                "First basemen are positioned to receive, have great hands, and are usually the best power hitter. As a striker your positioning in the box and clinical finishing are your weapons.",
                ["Box positioning", "First touch", "Physical presence", "Finishing", "Link play"],
                "Robert Lewandowski", "#E63946")
        case "Third Base":
            return make("Center Back", "CB", "The Hot-Corner Defender",
                "Third basemen have elite reflexes and physicality to handle anything fired at them. As a center back you're decisive, reactive, and win every battle.",
                ["Reflexes", "Physicality", "Decisive", "Reading the game", "Strength"],
                "Gerard Piqué", "#2D6A4F")
        default: // Outfielder
            return make("Winger", "RW/LW", "The Wide Tracker",
                "Outfielders cover huge ground, read the ball in the air, and are your most athletic players. As a winger your ability to track runs, press, and transition is elite.",
                ["Speed", "Tracking", "Athletic", "Transition play", "Wide threat"],
                "Sadio Mané", "#E63946")
        }
    }

    private static func hockey(_ pos: String) -> SoccerArchetype {
        switch pos {
        case "Goalie":
            return make("Goalkeeper", "GK", "The Reflex Machine",
                "Hockey goalies face bullets from every angle and react in milliseconds. Your lightning reflexes and fearlessness make you a wall between the posts.",
                ["Reflexes", "Fearlessness", "Positioning", "Shot-stopping", "Mental toughness"],
                "Marc-André ter Stegen", "#6D6875")
        case "Defenseman":
            return make("Full Back", "RB/LB", "The Composed Defender",
                "Hockey defensemen are dependable, physical, and can chip in offensively. As a full back you're solid at the back and effective when you join attacks.",
                ["Composure", "Physicality", "Defensive nous", "Overlapping", "Two-way play"],
                "Andy Robertson", "#2D6A4F")
        case "Center":
            return make("Central Midfielder", "CM", "The Box-to-Box Engine",
                "Hockey centers are two-way players who work hard at both ends. As a box-to-box midfielder you're tireless, versatile, and make an impact all over the pitch.",
                ["Two-way play", "Work rate", "Stamina", "Versatility", "Consistency"],
                "Frank Lampard", "#457B9D")
        default: // Left/Right Wing
            return make("Winger", "RW/LW", "The Direct Wide Attacker",
                "Hockey wingers attack aggressively and are the primary scoring threats. As a soccer winger you run at defenders, look to shoot, and create danger every time you receive.",
                ["Directness", "Speed", "Crossing", "Shooting", "1v1 ability"],
                "Mohamed Salah", "#E63946")
        }
    }

    private static func lacrosse(_ pos: String) -> SoccerArchetype {
        switch pos {
        case "Attack":
            return make("Striker", "ST", "The Clinical Finisher",
                "Lacrosse attackers live to score and are always looking to get their shot off. As a striker your goalscoring instinct and movement in the final third are world-class.",
                ["Clinical", "Movement", "Finishing", "Agility", "Goal-hungry"],
                "Robert Lewandowski", "#E63946")
        case "Midfielder":
            return make("Central Midfielder", "CM", "The Box-to-Box Dynamo",
                "Lacrosse midfielders cover the whole field and are incredibly fit. As a box-to-box midfielder you're powerful, energetic, and dangerous at both ends.",
                ["Stamina", "Power", "Two-way play", "Athleticism", "Drive"],
                "Yaya Touré", "#457B9D")
        case "Defense":
            return make("Center Back", "CB", "The Shutdown Defender",
                "Lacrosse defenders are physical, aggressive, and shut down the best attackers. As a center back you relish the battle and make strikers' lives miserable.",
                ["Aggressive", "Physical", "1v1 defending", "Commanding", "Relentless"],
                "Carles Puyol", "#2D6A4F")
        default: // Goalie
            return make("Goalkeeper", "GK", "The Reflex Machine",
                "Lacrosse goalies face point-blank shots constantly. Your lightning reflexes and bravery translate perfectly — you make the saves that look impossible.",
                ["Reflexes", "Bravery", "Quick reactions", "Communication", "Shot-stopping"],
                "Alisson Becker", "#6D6875")
        }
    }

    private static func rugby(_ pos: String) -> SoccerArchetype {
        switch pos {
        case "Prop", "Hooker":
            return make("Center Back", "CB", "The Physical Anchor",
                "Props and hookers are brutally physical and never take a backward step. You're a commanding center back who wins every aerial duel and intimidates strikers.",
                ["Physicality", "Strength", "Aerial dominance", "Intimidating", "Dominant"],
                "Nemanja Vidić", "#2D6A4F")
        case "Lock":
            return make("Center Back", "CB", "The Aerial Powerhouse",
                "Locks are the tallest and most powerful players on the pitch. Your aerial dominance and sheer presence make set pieces a nightmare for the opposition.",
                ["Aerial dominance", "Height", "Power", "Positioning", "Set-piece threat"],
                "Per Mertesacker", "#2D6A4F")
        case "Flanker", "Number 8":
            return make("Central Midfielder", "CM", "The Box-to-Box Powerhouse",
                "Flankers and number eights are the team's engine — tireless, physical, and impactful at both ends. You're a dominant box-to-box midfielder who never stops running.",
                ["Work rate", "Power", "Two-way play", "Ball-carrying", "Relentless"],
                "Yaya Touré", "#457B9D")
        case "Scrum-half":
            return make("Defensive Midfielder", "CDM", "The Quick Distributor",
                "Scrum-halves are quick-thinking, competitive, and distribute from the base of every play. You win the ball and immediately set the tempo with sharp passing.",
                ["Quick thinking", "Distribution", "Competitive", "Positioning", "Work rate"],
                "Sergio Busquets", "#457B9D")
        case "Fly-half":
            return make("Attacking Midfielder", "CAM", "The Creative Conductor",
                "Fly-halves control the game, pick the right play, and unlock any defense with a moment of brilliance. You make the creative decisions under pressure.",
                ["Vision", "Creativity", "Composure", "Decision-making", "Passing range"],
                "David Silva", "#F4A261")
        case "Wing":
            return make("Winger", "RW/LW", "The Explosive Edge Threat",
                "Rugby wings are the fastest athletes on the pitch who finish with power and precision. As a soccer winger you terrorize full backs with speed and always end up in dangerous positions.",
                ["Explosive pace", "Finishing", "Strength", "1v1 threat", "Direct"],
                "Gareth Bale", "#E63946")
        case "Centre":
            return make("Central Midfielder", "CM", "The Two-Way Midfielder",
                "Rugby centres are powerful, versatile, and contribute in attack and defense. You break lines, score goals, and track back to help out — a complete player.",
                ["Power", "Versatility", "Goal threat", "Tackling", "Line-breaking"],
                "Frank Lampard", "#457B9D")
        default: // Fullback
            return make("Goalkeeper", "GK", "The Sweeping Last Man",
                "Rugby fullbacks read the game brilliantly, clean up everything behind the line, and ignite attacks. You're a sweeper-keeper who dominates your area and starts counter-attacks.",
                ["Reading the game", "Sweeping", "Counter-attack starter", "Positioning", "Clutch"],
                "Manuel Neuer", "#6D6875")
        }
    }

    private static func volleyball(_ pos: String) -> SoccerArchetype {
        switch pos {
        case "Setter":
            return make("Central Midfielder", "CM", "The Master Distributor",
                "Setters touch the ball more than anyone, make split-second decisions, and set teammates up to score. Your vision and touch make everyone around you better.",
                ["Vision", "Touch", "Decision-making", "Leadership", "Creativity"],
                "Xavi Hernández", "#457B9D")
        case "Outside Hitter":
            return make("Winger", "RW/LW", "The Primary Wide Weapon",
                "Outside hitters are the go-to scoring option. As a winger you're the team's primary attacking outlet — taking on defenders, cutting inside, and creating or finishing chances.",
                ["Scoring instinct", "Athleticism", "Directness", "1v1 threat", "Versatility"],
                "Arjen Robben", "#E63946")
        case "Middle Blocker":
            return make("Center Back", "CB", "The Aerial Specialist",
                "Middle blockers are the tallest players and dominate at the net. Your aerial ability and timing make you an imposing force at both ends of the pitch.",
                ["Aerial dominance", "Timing", "Height", "Blocking / Defending", "Presence"],
                "Raphaël Varane", "#2D6A4F")
        case "Libero":
            return make("Defensive Midfielder", "CDM", "The Recovery Specialist",
                "Liberos are the defensive specialist who saves everything and makes the unreachable look routine. You cover for everyone, win the ball, and keep the team organized.",
                ["Recovery", "Positioning", "Tenacity", "Reading the game", "Ball-winning"],
                "Claude Makélélé", "#457B9D")
        default: // Opposite Hitter
            return make("Striker", "ST", "The Big Hitter",
                "Opposite hitters are the most powerful hitters on the team, scoring in key moments. As a striker you're a goalscoring force of nature who rises to big occasions.",
                ["Power", "Scoring ability", "Big-game mentality", "Athleticism", "Finishing"],
                "Zlatan Ibrahimović", "#E63946")
        }
    }

    private static func tennis(_ pos: String) -> SoccerArchetype {
        switch pos {
        case "Serve & Volley":
            return make("Striker", "ST", "The High-Press Forward",
                "Serve-and-volleyers attack quickly, win points at the net, and never give opponents time. As a pressing striker you suffocate defenders, win the ball high, and finish ruthlessly.",
                ["High press", "Aggression", "Quick thinking", "Finishing", "Intensity"],
                "Roberto Firmino", "#E63946")
        case "Aggressive Baseliner":
            return make("Winger", "RW/LW", "The Direct Wide Threat",
                "Aggressive baseliners hit with pace and purpose — always looking to dictate. As a winger you run at defenders with conviction, commit, and shoot powerfully.",
                ["Pace", "Directness", "Power", "1v1 threat", "Shot"],
                "Kylian Mbappé", "#E63946")
        case "Defensive Baseliner":
            return make("Defensive Midfielder", "CDM", "The Tireless Retriever",
                "Defensive baseliners frustrate opponents, retrieve everything, and outlast them. You track every run, win every duel, and are the tireless shield your team relies on.",
                ["Tenacity", "Endurance", "Ball-winning", "Positioning", "Mental strength"],
                "N'Golo Kanté", "#457B9D")
        default: // All-Court
            return make("Central Midfielder", "CM", "The Box-to-Box All-Rounder",
                "All-court players have no weakness — attack, defend, and adapt. As a box-to-box midfielder you're the complete midfield package: engine, creator, and goal threat.",
                ["Adaptability", "All-round quality", "Power", "Creativity", "Consistency"],
                "Paul Pogba", "#457B9D")
        }
    }

    private static func swimming(_ pos: String) -> SoccerArchetype {
        switch pos {
        case "Sprinter (50–100m)":
            return make("Winger", "RW/LW", "The Pure Speedster",
                "Short-distance swimmers have elite fast-twitch muscle. As a winger your raw acceleration leaves defenders for dead — one of the fastest players on the pitch.",
                ["Explosive pace", "Acceleration", "Directness", "Transition threat", "Wide play"],
                "Kylian Mbappé", "#E63946")
        case "Middle Distance (200–400m)":
            return make("Striker", "ST", "The Well-Rounded Forward",
                "Middle-distance swimmers combine speed with endurance. As a striker you have the pace to run in behind, the stamina to press for 90 minutes, and are a constant threat.",
                ["Speed", "Endurance", "Work rate", "Movement", "Pressing"],
                "Harry Kane", "#E63946")
        case "Distance (800m+)":
            return make("Central Midfielder", "CM", "The Lungs of the Team",
                "Distance swimmers have extraordinary cardiovascular capacity. As a box-to-box midfielder you never stop running — covering 13+ km per game while maintaining quality throughout.",
                ["Endurance", "Work rate", "Consistency", "Stamina", "Covering ground"],
                "James Milner", "#457B9D")
        default: // IM
            return make("Central Midfielder", "CM", "The Versatile Engine",
                "IM swimmers are the most complete athletes in the pool — excelling in every stroke. As a central midfielder you adapt to any system and perform at an elite level in any situation.",
                ["Versatility", "Complete", "Adaptable", "Fitness", "Intelligence"],
                "Kevin De Bruyne", "#457B9D")
        }
    }

    private static func trackField(_ pos: String) -> SoccerArchetype {
        switch pos {
        case "Sprinter":
            return make("Winger", "RW/LW", "The Pace Merchant",
                "Track sprinters are the fastest humans alive. As a winger you terrorize defenses with pure pace — running in behind, beating defenders on the outside, and stretching the game.",
                ["Pure pace", "Directness", "Acceleration", "Transition threat", "Wide play"],
                "Leroy Sané", "#E63946")
        case "Distance Runner":
            return make("Central Midfielder", "CM", "The Relentless Runner",
                "Distance runners have the best VO2 max of any athlete. As a central midfielder you run tirelessly for 90+ minutes — pressing and recovering endlessly, the engine of the team.",
                ["Endurance", "Work rate", "Stamina", "Pressing", "Consistency"],
                "Toni Kroos", "#457B9D")
        case "Jumper":
            return make("Striker", "ST", "The Athletic Aerial Finisher",
                "Jumpers have explosive power, exceptional timing, and dominate in the air. As a striker your heading ability and athleticism make you a constant aerial threat.",
                ["Aerial ability", "Explosive power", "Timing", "Athletic", "Goal threat"],
                "Cristiano Ronaldo", "#E63946")
        default: // Thrower
            return make("Center Back", "CB", "The Powerhouse Defender",
                "Throwers have raw physical power and explosive strength. As a center back you're an immovable force — dominating aerial duels, bulldozing through attackers, and commanding your box.",
                ["Raw power", "Strength", "Aerial dominance", "Physical dominance", "Imposing"],
                "Virgil van Dijk", "#2D6A4F")
        }
    }

    // MARK: - Helpers

    private static func make(
        _ position: String, _ code: String, _ name: String,
        _ desc: String, _ traits: [String], _ player: String, _ color: String
    ) -> SoccerArchetype {
        SoccerArchetype(position: position, positionCode: code, archetypeName: name,
                        description: desc, traits: traits,
                        playerComparison: "Think: \(player)", accentColor: color)
    }

    private static func fallback() -> SoccerArchetype {
        make("Central Midfielder", "CM", "The Complete Player",
            "Your athletic background makes you a natural in the middle of the park — versatile, competitive, and able to influence the game at both ends.",
            ["Versatile", "Competitive", "Athletic", "Team player", "Consistent"],
            "Luka Modrić", "#457B9D")
    }
}
