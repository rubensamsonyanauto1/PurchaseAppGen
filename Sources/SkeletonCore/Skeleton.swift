import Foundation
import SkeletonTemplates
import PathKit

public struct Input {
    let name: String
    let folder: String
    let type: String

    public init(name: String, folder: String, type: String) {
        self.name = name
        self.folder = folder
        self.type = type
    }
}

public enum SkeletonError: Error {
    case nonExistingType(String)
    case fileExist(String)
    case unableToCreateFile(String)
}

public final class Skeleton {
    private let input: Input

    public init(input: Input) {
        self.input = input
    }

    public func run() throws {
        let options = [
            "$NAME$": input.name,
            "$CAMELCASED_NAME$": input.name.prefix(1).lowercased() + input.name.dropFirst(),
        ]
        let path = Path.current + Path(input.folder) + Path(input.name)
        if !path.exists {
            try path.mkpath()
        }
        guard let type = TemplateType(rawValue: input.type) else {
            throw SkeletonError.nonExistingType("Possible values: `basic`")
        }
        let templates = TemplateFactory.makeTemplates(forType: type)
        let parser = TemplatesParser(path: path, name: input.name)
        let files = parser.parse(templates: templates, params: options)
        let manager = FileManager.default
        try files.forEach { file in
            let isCreated = manager.createFile(atPath: file.fullPath.string, contents: file.content.data(using: .utf8))
            guard isCreated else {
                throw SkeletonError.unableToCreateFile(file.fullPath.string)
            }
        }
    }
}
