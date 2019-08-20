import Foundation
import PathKit
import SkeletonTemplates

protocol File {
    var fullPath: Path { get }
    func write() throws
}

extension TemplateFile: File {
    var fullPath: Path {
        return path + Path("\(name).\(ext)")
    }

    func write() throws {
        let fullPath = self.fullPath
        guard !fullPath.exists else {
            throw SkeletonError.fileExist(fullPath.description)
        }
        try fullPath.mkdir()
        try fullPath.write(content)
    }
}