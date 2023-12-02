import Algorithms

struct Day02: AdventDay {
    var data: String
    
    var games: [Game] {
        data
            .split(whereSeparator: \.isNewline)
            .compactMap { Game(String($0)) }
    }
    
    func part1() -> Any {
        var potentialGameIDs: [Int] = []
        for game in games {
            var isGamePossibleToWin = true
            for set in game.sets {
                for cubes in set {
                    switch cubes {
                    case .red(let count):
                        if count > 12 { isGamePossibleToWin = false }
                    case .blue(let count):
                        if count > 14 { isGamePossibleToWin = false }
                    case .green(let count):
                        if count > 13 { isGamePossibleToWin = false }
                    }
                }
            }
            if isGamePossibleToWin { potentialGameIDs.append(game.id) }
        }
        return potentialGameIDs.reduce(0, +)
    }
    
    func part2() -> Any {
        var gamePowers: [Int] = []
        for game in games {
            var minimalCubes: [String:Int] = [:]
            for set in game.sets {
                for cubes in set {
                    switch cubes {
                    case .red(let count):
                        if let currentMin = minimalCubes["red"] {
                            if count > currentMin { minimalCubes["red"] = count }
                        } else {
                            minimalCubes["red"] = count
                        }
                    case .blue(let count):
                        if let currentMin = minimalCubes["blue"] {
                            if count > currentMin { minimalCubes["blue"] = count }
                        } else {
                            minimalCubes["blue"] = count
                        }
                    case .green(let count):
                        if let currentMin = minimalCubes["green"] {
                            if count > currentMin { minimalCubes["green"] = count }
                        } else {
                            minimalCubes["green"] = count
                        }
                    }
                }
            }
            gamePowers.append(minimalCubes.values.reduce(1, *))
        }
        return gamePowers.reduce(0, +)
    }
    
    struct Game {
        let id: Int
        let sets: [[Cubes]]
        
        init?(_ input: String) {
            let (game, sets) = input.splitOnce(":")!
            let (_, id) = String(game).splitOnce(" ")!
            let gameSets = sets
                .components(separatedBy: "; ")
                .map { $0.components(separatedBy: ",").compactMap { Cubes($0) } }
            
            self.id = Int(id)!
            self.sets = gameSets
        }
        
        enum Cubes: Hashable {
            case red(Int)
            case blue(Int)
            case green(Int)
            
            init?(_ cubes: String) {
                guard let (count, color) = cubes.trimmingCharacters(in: .whitespaces).splitOnce(" "),
                      let count = Int(count) else { return nil }
                
                switch color {
                case "red": self = .red(count)
                case "blue": self = .blue(count)
                case "green": self = .green(count)
                default: return nil
                }
            }
        }
    }
}
