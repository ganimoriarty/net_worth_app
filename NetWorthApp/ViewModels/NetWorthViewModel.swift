import Foundation
import SwiftUI

@MainActor
final class NetWorthViewModel: ObservableObject {
    @Published private(set) var assets: [Asset]
    @Published private(set) var liabilities: [Liability]
    @Published private(set) var history: [NetWorthEntry]
    @Published private(set) var debtSchedule: [DebtPaymentProjection]

    private let wealthLadder = WealthLadderFactory.kazakhstanLadder()
    private let usdExchangeRate: Double = 450.0

    init(
        assets: [Asset] = PreviewData.sampleAssets,
        liabilities: [Liability] = PreviewData.sampleLiabilities,
        history: [NetWorthEntry] = PreviewData.sampleHistory
    ) {
        self.assets = assets
        self.liabilities = liabilities
        self.history = history.sorted { $0.date < $1.date }
        self.debtSchedule = []
        self.debtSchedule = generateDebtSchedule()
    }

    var assetsTotal: Double { assets.map(\.amountKZT).reduce(0, +) }
    var liabilitiesTotal: Double { liabilities.map(\.amountKZT).reduce(0, +) }
    var netWorthKZT: Double { assetsTotal - liabilitiesTotal }
    var netWorthUSD: Double { netWorthKZT / usdExchangeRate }

    var currentWealthStep: WealthLadderStep? {
        wealthLadder.first { $0.matches(netWorth: netWorthKZT) }
    }

    var snapshot: NetWorthSnapshot {
        let cashTotal = assets.filter { $0.category == .cash }.map(\.amountKZT).reduce(0, +)
        let depositsTotal = assets.filter { $0.category == .deposits }.map(\.amountKZT).reduce(0, +)
        let internationalTotal = assets.filter { $0.category == .internationalInvestments }.map(\.amountKZT).reduce(0, +)
        let realEstateTotal = assets.filter { $0.category == .realEstate }.map(\.amountKZT).reduce(0, +)
        let businessTotal = assets.filter { $0.category == .business }.map(\.amountKZT).reduce(0, +)
        return NetWorthSnapshot(
            assetsTotal: assetsTotal,
            liabilitiesTotal: liabilitiesTotal,
            cashTotal: cashTotal,
            depositsTotal: depositsTotal,
            internationalExposureShare: assetsTotal == 0 ? 0 : internationalTotal / assetsTotal,
            realEstateShare: assetsTotal == 0 ? 0 : realEstateTotal / assetsTotal,
            businessShare: assetsTotal == 0 ? 0 : businessTotal / assetsTotal
        )
    }

    var aiRecommendations: [String] {
        AIRecommendationEngine.recommendations(for: snapshot)
    }

    func addAsset(_ asset: Asset) {
        assets.append(asset)
        recalculate()
    }

    func addLiability(_ liability: Liability) {
        liabilities.append(liability)
        recalculate()
    }

    func updateHistory(with entry: NetWorthEntry) {
        history.append(entry)
        history.sort { $0.date < $1.date }
    }

    func removeAssets(at offsets: IndexSet) {
        assets.remove(atOffsets: offsets)
        recalculate()
    }

    func removeLiabilities(at offsets: IndexSet) {
        liabilities.remove(atOffsets: offsets)
        recalculate()
    }

    private func recalculate() {
        debtSchedule = generateDebtSchedule()
        let newEntry = NetWorthEntry(date: Date(), assetsTotal: assetsTotal, liabilitiesTotal: liabilitiesTotal)
        if let last = history.last, Calendar.current.isDate(last.date, inSameDayAs: newEntry.date) {
            history.removeLast()
        }
        history.append(newEntry)
    }

    private func generateDebtSchedule() -> [DebtPaymentProjection] {
        guard !liabilities.isEmpty else { return [] }
        var liabilitiesCopy = liabilities
        var schedule: [DebtPaymentProjection] = []
        var currentMonth = Date()
        var iteration = 0
        let maxIterations = 600

        func totalRemaining() -> Double {
            liabilitiesCopy.map(\.amountKZT).reduce(0, +)
        }

        while totalRemaining() > 0.1 && iteration < maxIterations {
            for index in liabilitiesCopy.indices {
                let monthlyInterest = liabilitiesCopy[index].amountKZT * liabilitiesCopy[index].interestRate / 12
                let principalPaid = max(liabilitiesCopy[index].monthlyPayment - monthlyInterest, 0)
                liabilitiesCopy[index].amountKZT = max(liabilitiesCopy[index].amountKZT - principalPaid, 0)
            }
            schedule.append(DebtPaymentProjection(month: currentMonth, remainingDebt: totalRemaining()))
            guard let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: currentMonth) else { break }
            currentMonth = nextMonth
            iteration += 1
        }
        return schedule
    }
}
