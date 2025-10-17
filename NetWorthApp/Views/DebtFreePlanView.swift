import SwiftUI
import Charts

struct DebtFreePlanView: View {
    @EnvironmentObject private var viewModel: NetWorthViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("debt_plan_title")
                .font(.headline)
            if viewModel.debtSchedule.isEmpty {
                Text("debt_plan_empty")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            } else {
                Chart(viewModel.debtSchedule) { projection in
                    BarMark(
                        x: .value("month", projection.month),
                        y: .value("remaining", projection.remainingDebt)
                    )
                    .foregroundStyle(Color.red.opacity(0.4))
                }
                .chartXAxis {
                    AxisMarks(values: .stride(by: .month, count: 3)) { value in
                        if let date = value.as(Date.self) {
                            AxisGridLine()
                            AxisValueLabel(Formatter.monthFormatter.string(from: date))
                        }
                    }
                }
                .chartYAxis {
                    AxisMarks(position: .leading)
                }
                .frame(height: 220)
                if let completionDate = viewModel.debtSchedule.last?.month {
                    Text(String(format: NSLocalizedString("debt_plan_completion", comment: ""), Formatter.monthFormatter.string(from: completionDate)))
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}
