import Foundation

public enum TemplateType: String {
    case basic
}

public struct TemplateFactory {
    public static func makeTemplates(forType type: TemplateType) -> [Template] {
        switch type {
        case .basic:
            return makeBasicTemplates()
        }
    }

    private static func makeBasicTemplates() -> [Template] {
        return [
            BasicTemplateNamespace(),
            BasicTemplateAssembly(),
            BasicTemplateNavigationHandler(),
            BasicTemplateViewController(),
            BasicTemplateViewModel(),
            BasicTemplateRunSpec()
        ]
    }
}