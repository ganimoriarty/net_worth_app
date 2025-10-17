import SwiftUI

struct RecommendationsView: View {
    @EnvironmentObject private var viewModel: NetWorthViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("ai_title")
                .font(.headline)
            ForEach(viewModel.aiRecommendations, id: \.self) { key in
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: "sparkles")
                        .foregroundStyle(.yellow)
                    Text(LocalizedStringKey(key))
                        .font(.body)
                }
                .padding(.vertical, 4)
                Divider()
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}
