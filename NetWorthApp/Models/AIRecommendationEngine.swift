import Foundation

enum AIRecommendationEngine {
    static func recommendations(for viewModel: NetWorthSnapshot) -> [String] {
        var messages: [String] = []
        let savingsRate = viewModel.assetsTotal == 0 ? 0 : (viewModel.cashTotal + viewModel.depositsTotal) / viewModel.assetsTotal
        if savingsRate < 0.15 {
            messages.append("ai_increase_cash")
        }
        if viewModel.liabilitiesTotal > viewModel.assetsTotal * 0.6 {
            messages.append("ai_reduce_debt")
        }
        if viewModel.internationalExposureShare < 0.2 {
            messages.append("ai_expand_international")
        }
        if viewModel.realEstateShare < 0.3 {
            messages.append("ai_review_real_estate")
        }
        if viewModel.businessShare < 0.1 {
            messages.append("ai_develop_business")
        }
        if messages.isEmpty {
            messages.append("ai_keep_up")
        }
        return messages
    }
}

struct NetWorthSnapshot {
    let assetsTotal: Double
    let liabilitiesTotal: Double
    let cashTotal: Double
    let depositsTotal: Double
    let internationalExposureShare: Double
    let realEstateShare: Double
    let businessShare: Double
}
