import SwiftUI
import Charts

struct NetWorthChartView: View {
    let entries: [NetWorthEntry]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("chart_title")
                .font(.headline)
            Chart(entries) { entry in
                LineMark(
                    x: .value("date", entry.date),
                    y: .value("netWorth", entry.netWorth)
                )
                .foregroundStyle(Color.accentColor)
                PointMark(
                    x: .value("date", entry.date),
                    y: .value("netWorth", entry.netWorth)
                )
                .annotation(position: .top) {
                    Text(Formatter.currencyKZT.string(from: NSNumber(value: entry.netWorth)) ?? "-")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }
            .chartXAxis {
                AxisMarks(values: .stride(by: .month, count: 1)) { value in
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
            Text("chart_description")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}
