import SwiftUI

struct WealthLadderView: View {
    @EnvironmentObject private var viewModel: NetWorthViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("ladder_title")
                .font(.headline)
            if let step = viewModel.currentWealthStep {
                Text("ladder_current")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                HStack {
                    Text(LocalizedStringKey(step.titleKey))
                        .fontWeight(.semibold)
                    Spacer()
                }
            }
            VStack(alignment: .leading, spacing: 8) {
                ForEach(WealthLadderFactory.kazakhstanLadder()) { step in
                    HStack(alignment: .center, spacing: 8) {
                        Text(LocalizedStringKey(step.titleKey))
                        Spacer()
                        Text(Formatter.currencyKZT.string(from: NSNumber(value: step.range.lowerBound)) ?? "-")
                        Text("-")
                        Text(step.range.upperBound.isFinite ? (Formatter.currencyKZT.string(from: NSNumber(value: step.range.upperBound)) ?? "-") : "∞")
                    }
                    .font(.caption)
                    .padding(.vertical, 4)
                    Divider()
                }
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}
