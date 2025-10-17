import SwiftUI

struct AssetsView: View {
    @EnvironmentObject private var viewModel: NetWorthViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("assets_title")
                .font(.headline)
            ForEach(AssetCategory.allCases) { category in
                if let assets = viewModel.assets(for: category), !assets.isEmpty {
                    AssetCategorySection(titleKey: LocalizedStringKey(category.localizationKey), assets: assets)
                }
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

private struct AssetCategorySection: View {
    let titleKey: LocalizedStringKey
    let assets: [Asset]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(titleKey)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            ForEach(Array(assets.enumerated()), id: \.element.id) { index, asset in
                HStack {
                    VStack(alignment: .leading) {
                        Text(asset.name)
                        Text(Formatter.currencyKZT.string(from: NSNumber(value: asset.amountKZT)) ?? "-")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                }
                .padding(.vertical, 6)
                if index < assets.count - 1 {
                    Divider()
                }
            }
        }
    }
}

private extension NetWorthViewModel {
    func assets(for category: AssetCategory) -> [Asset]? {
        let filtered = assets.filter { $0.category == category }
        return filtered.isEmpty ? nil : filtered
    }
}
