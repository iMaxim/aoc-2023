extension String {
    func splitOnce(_ delimiter: Character) -> (String.SubSequence, String.SubSequence)? {
        guard let index = self.firstIndex(of: delimiter) else { return nil }
        return (self.prefix(upTo: index), self.suffix(from: self.index(after: index)))
    }
}
