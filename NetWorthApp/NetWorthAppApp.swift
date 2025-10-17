import SwiftUI

@main
struct NetWorthAppApp: App {
    @StateObject private var viewModel = NetWorthViewModel()
    @State private var selectedLanguage: AppLanguage = .russian

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .environment(\.locale, Locale(identifier: selectedLanguage.localeIdentifier))
                .environmentObject(LanguageManager(selectedLanguage: $selectedLanguage))
        }
    }
}
