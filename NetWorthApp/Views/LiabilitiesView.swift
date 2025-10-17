import SwiftUI

struct LiabilitiesView: View {
    @EnvironmentObject private var viewModel: NetWorthViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("liabilities_title")
                .font(.headline)
            ForEach(LiabilityCategory.allCases) { category in
                if let liabilities = viewModel.liabilities(for: category), !liabilities.isEmpty {
                    LiabilityCategorySection(titleKey: LocalizedStringKey(category.localizationKey), liabilities: liabilities)
                }
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

private struct LiabilityCategorySection: View {
    let titleKey: LocalizedStringKey
    let liabilities: [Liability]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(titleKey)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            ForEach(Array(liabilities.enumerated()), id: \.element.id) { index, liability in
                VStack(alignment: .leading, spacing: 4) {
                    Text(liability.name)
                    Text(Formatter.currencyKZT.string(from: NSNumber(value: liability.amountKZT)) ?? "-")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(String(format: "%.1f%%", liability.interestRate * 100))
                        .font(.caption2)
                        .foregroundStyle(.tertiary)
                }
                .padding(.vertical, 6)
                if index < liabilities.count - 1 {
                    Divider()
                }
            }
        }
    }
}

private extension NetWorthViewModel {
    func liabilities(for category: LiabilityCategory) -> [Liability]? {
        let filtered = liabilities.filter { $0.category == category }
        return filtered.isEmpty ? nil : filtered
    }
}
