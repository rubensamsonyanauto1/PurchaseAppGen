import Foundation

public protocol Template {
    var content: String { get }
    var fileNameSuffix: String { get }
}
