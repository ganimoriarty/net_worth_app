import Foundation

struct WealthLadderStep: Identifiable, Codable {
    let id: UUID
    let titleKey: String
    let range: ClosedRange<Double>

    init(id: UUID = UUID(), titleKey: String, range: ClosedRange<Double>) {
        self.id = id
        self.titleKey = titleKey
        self.range = range
    }

    func matches(netWorth: Double) -> Bool {
        range.contains(netWorth)
    }
}

enum WealthLadderFactory {
    static func kazakhstanLadder() -> [WealthLadderStep] {
        [
            WealthLadderStep(titleKey: "ladder_starter", range: 0...2_000_000),
            WealthLadderStep(titleKey: "ladder_builder", range: 2_000_001...10_000_000),
            WealthLadderStep(titleKey: "ladder_accumulator", range: 10_000_001...40_000_000),
            WealthLadderStep(titleKey: "ladder_investor", range: 40_000_001...150_000_000),
            WealthLadderStep(titleKey: "ladder_established", range: 150_000_001...500_000_000),
            WealthLadderStep(titleKey: "ladder_legacy", range: 500_000_001...1_000_000_000),
            WealthLadderStep(titleKey: "ladder_elite", range: 1_000_000_001...5_000_000_000),
            WealthLadderStep(titleKey: "ladder_ultra", range: 5_000_000_001...10_000_000_000),
            WealthLadderStep(titleKey: "ladder_sovereign", range: 10_000_000_001...Double.greatestFiniteMagnitude)
        ]
    }
}
