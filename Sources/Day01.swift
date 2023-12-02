import Algorithms

struct Day01: AdventDay {
    var data: String
    
    var entities: [String] {
        data.split(separator: "\n").map { String($0) }
    }
    
    let wordNumberPairs = [
        "1": 1,
        "2": 2,
        "3": 3,
        "4": 4,
        "5": 5,
        "6": 6,
        "7": 7,
        "8": 8,
        "9": 9,
        "one": 1,
        "two": 2,
        "three": 3,
        "four": 4,
        "five": 5,
        "six": 6,
        "seven": 7,
        "eight": 8,
        "nine": 9
    ]
    
    func part1() -> Any {
        entities
            .compactMap { firstAndLast($0.components(separatedBy: .letters).joined()) }
            .reduce(0) { $0 + Int($1)! }
    }
    
    func part2() -> Any {
        entities
            .map { parse($0) }
            .compactMap { firstAndLast($0.components(separatedBy: .letters).joined()) }
            .reduce(0) { $0 + Int($1)! }
    }
    
    func firstAndLast(_ input: String) -> String? {
        guard let first = input.first, let last = input.last else { return nil }
        return "\(first)\(last)"
    }
    
    func parse(_ line: String) -> String {
        var cleanedNumbersFromLine: [Int] = []
        let endIndex = line.endIndex
        var currentIndex = line.startIndex
        
        while currentIndex != endIndex {
            for offset in 1...5 {
                guard let currentOffsetIndex = line.index(currentIndex,
                                                          offsetBy: offset,
                                                          limitedBy: endIndex) else { break }
                let slice = line[currentIndex..<currentOffsetIndex]
                if let pair = wordNumberPairs[String(slice)] {
                    cleanedNumbersFromLine.append(pair)
                    break
                }
            }
            currentIndex = line.index(currentIndex, offsetBy: 1)
        }
        
        return cleanedNumbersFromLine.compactMap { String($0) }.joined()
    }
}
