import Foundation
import PathKit

public struct TemplatesParser {
    let path: Path
    let name: String

    public init(path: Path, name: String) {
        self.path = path
        self.name = name
    }

    public func parse(templates: [Template], params: [String: String]) -> [TemplateFile] {
        return templates.map { self.parse(template: $0, params: params) }
    }

    private func parse(template: Template, params: [String: String]) -> TemplateFile {
        let content = params.reduce(into: template.content) { $0 = $0.replacingOccurrences(of: $1.key, with: $1.value) }
        return TemplateFile(
            name: "\(name)\(template.fileNameSuffix)",
            path: path,
            ext: "swift", 
            content: content
        )
    }
}