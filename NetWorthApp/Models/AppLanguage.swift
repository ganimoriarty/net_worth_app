import Foundation
import SwiftUI

enum AppLanguage: String, CaseIterable, Identifiable {
    case russian = "ru"
    case kazakh = "kk"

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .russian:
            return "Русский"
        case .kazakh:
            return "Қазақша"
        }
    }

    var localeIdentifier: String { rawValue }
}

final class LanguageManager: ObservableObject {
    private var selectedLanguageBinding: Binding<AppLanguage>

    init(selectedLanguage: Binding<AppLanguage>) {
        self.selectedLanguageBinding = selectedLanguage
    }

    var selectedLanguage: AppLanguage {
        get { selectedLanguageBinding.wrappedValue }
        set {
            selectedLanguageBinding.wrappedValue = newValue
            objectWillChange.send()
        }
    }

    func binding() -> Binding<AppLanguage> {
        Binding(
            get: { self.selectedLanguage },
            set: { self.selectedLanguage = $0 }
        )
    }
}
