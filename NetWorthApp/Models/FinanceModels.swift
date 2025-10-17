import Foundation

enum AssetCategory: String, CaseIterable, Identifiable, Codable {
    case cash
    case deposits
    case kaseInvestments
    case aixInvestments
    case internationalInvestments
    case realEstate
    case business

    var id: String { rawValue }

    var localizationKey: String {
        switch self {
        case .cash: return "asset_cash"
        case .deposits: return "asset_deposits"
        case .kaseInvestments: return "asset_kase"
        case .aixInvestments: return "asset_aix"
        case .internationalInvestments: return "asset_international"
        case .realEstate: return "asset_real_estate"
        case .business: return "asset_business"
        }
    }
}

enum LiabilityCategory: String, CaseIterable, Identifiable, Codable {
    case kaspiLoan
    case mortgage
    case otherDebt

    var id: String { rawValue }

    var localizationKey: String {
        switch self {
        case .kaspiLoan: return "liability_kaspi"
        case .mortgage: return "liability_mortgage"
        case .otherDebt: return "liability_other"
        }
    }
}

struct Asset: Identifiable, Codable {
    let id: UUID
    let category: AssetCategory
    var name: String
    var amountKZT: Double

    init(id: UUID = UUID(), category: AssetCategory, name: String, amountKZT: Double) {
        self.id = id
        self.category = category
        self.name = name
        self.amountKZT = amountKZT
    }
}

struct Liability: Identifiable, Codable {
    let id: UUID
    let category: LiabilityCategory
    var name: String
    var amountKZT: Double
    var interestRate: Double
    var monthlyPayment: Double

    init(
        id: UUID = UUID(),
        category: LiabilityCategory,
        name: String,
        amountKZT: Double,
        interestRate: Double,
        monthlyPayment: Double
    ) {
        self.id = id
        self.category = category
        self.name = name
        self.amountKZT = amountKZT
        self.interestRate = interestRate
        self.monthlyPayment = monthlyPayment
    }
}

struct NetWorthEntry: Identifiable, Codable {
    let id: UUID
    let date: Date
    let assetsTotal: Double
    let liabilitiesTotal: Double

    var netWorth: Double { assetsTotal - liabilitiesTotal }

    init(id: UUID = UUID(), date: Date, assetsTotal: Double, liabilitiesTotal: Double) {
        self.id = id
        self.date = date
        self.assetsTotal = assetsTotal
        self.liabilitiesTotal = liabilitiesTotal
    }
}

struct DebtPaymentProjection: Identifiable, Codable {
    let id: UUID
    let month: Date
    let remainingDebt: Double

    init(id: UUID = UUID(), month: Date, remainingDebt: Double) {
        self.id = id
        self.month = month
        self.remainingDebt = remainingDebt
    }
}
