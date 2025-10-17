import SwiftUI
import Charts

struct ContentView: View {
    @EnvironmentObject private var viewModel: NetWorthViewModel
    @EnvironmentObject private var languageManager: LanguageManager

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    LanguagePicker(selectedLanguage: languageManager.binding())
                    NetWorthSummaryView()
                    NetWorthChartView(entries: viewModel.history)
                    AssetsView()
                    LiabilitiesView()
                    WealthLadderView()
                    RecommendationsView()
                    DebtFreePlanView()
                }
                .padding()
            }
            .navigationTitle(Text("app_title"))
            .background(Color(UIColor.systemGroupedBackground))
        }
    }
}

struct LanguagePicker: View {
    @Binding var selectedLanguage: AppLanguage

    var body: some View {
        Picker("language_picker", selection: $selectedLanguage) {
            ForEach(AppLanguage.allCases) { language in
                Text(language.displayName).tag(language)
            }
        }
        .pickerStyle(.segmented)
    }
}
