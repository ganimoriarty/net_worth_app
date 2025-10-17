import Foundation

enum PreviewData {
    static let sampleAssets: [Asset] = [
        Asset(category: .cash, name: "Kaspi Gold", amountKZT: 1_200_000),
        Asset(category: .deposits, name: "Jusan Bank", amountKZT: 5_000_000),
        Asset(category: .kaseInvestments, name: "KASE ETF", amountKZT: 2_500_000),
        Asset(category: .aixInvestments, name: "AIX IPO", amountKZT: 3_200_000),
        Asset(category: .internationalInvestments, name: "S&P 500", amountKZT: 4_800_000),
        Asset(category: .realEstate, name: "Алматы квартира", amountKZT: 45_000_000),
        Asset(category: .business, name: "Кофейня", amountKZT: 20_000_000)
    ]

    static let sampleLiabilities: [Liability] = [
        Liability(category: .kaspiLoan, name: "Kaspi рассрочка", amountKZT: 1_000_000, interestRate: 0.08, monthlyPayment: 85_000),
        Liability(category: .mortgage, name: "Баспана Hit", amountKZT: 28_000_000, interestRate: 0.075, monthlyPayment: 220_000),
        Liability(category: .otherDebt, name: "Автокредит", amountKZT: 5_000_000, interestRate: 0.12, monthlyPayment: 180_000)
    ]

    static let sampleHistory: [NetWorthEntry] = {
        let calendar = Calendar.current
        let today = Date()
        return (0..<12).compactMap { monthOffset in
            guard let date = calendar.date(byAdding: .month, value: -monthOffset, to: today) else { return nil }
            let assets = 70_000_000 + Double(monthOffset) * 500_000
            let liabilities = 35_000_000 - Double(monthOffset) * 400_000
            return NetWorthEntry(date: date, assetsTotal: assets, liabilitiesTotal: liabilities)
        }.sorted { $0.date < $1.date }
    }()
}
