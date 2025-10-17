import SwiftUI

struct NetWorthSummaryView: View {
    @EnvironmentObject private var viewModel: NetWorthViewModel

    private let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "KZT"
        formatter.maximumFractionDigits = 0
        return formatter
    }()

    private let usdFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        formatter.maximumFractionDigits = 0
        return formatter
    }()

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("summary_title")
                .font(.title2)
                .fontWeight(.semibold)
            HStack {
                VStack(alignment: .leading) {
                    Text("summary_net_worth_kzt")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(currencyFormatter.string(from: NSNumber(value: viewModel.netWorthKZT)) ?? "-")
                        .font(.title)
                        .fontWeight(.bold)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("summary_net_worth_usd")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(usdFormatter.string(from: NSNumber(value: viewModel.netWorthUSD)) ?? "-")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
            }
            HStack(spacing: 32) {
                SummaryMetricView(
                    titleKey: "summary_assets",
                    value: currencyFormatter.string(from: NSNumber(value: viewModel.assetsTotal)) ?? "-",
                    style: .green
                )
                SummaryMetricView(
                    titleKey: "summary_liabilities",
                    value: currencyFormatter.string(from: NSNumber(value: viewModel.liabilitiesTotal)) ?? "-",
                    style: .red
                )
            }
            if let step = viewModel.currentWealthStep {
                WealthLadderBadge(titleKey: step.titleKey)
            }
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}

struct SummaryMetricView: View {
    enum Style {
        case green
        case red
    }

    let titleKey: LocalizedStringKey
    let value: String
    let style: Style

    var body: some View {
        VStack(alignment: .leading) {
            Text(titleKey)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(value)
                .font(.headline)
                .foregroundStyle(style == .green ? .green : .red)
        }
    }
}

struct WealthLadderBadge: View {
    let titleKey: LocalizedStringKey

    var body: some View {
        HStack {
            Image(systemName: "flag.checkered")
            Text(titleKey)
                .fontWeight(.medium)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(Color.blue.opacity(0.1), in: Capsule())
    }
}
