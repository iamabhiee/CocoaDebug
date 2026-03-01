import Foundation

enum CocoaDebugBundle {
    static var resource: Bundle {
        #if SWIFT_PACKAGE
        return .module
        #else
        return Bundle(for: CocoaDebug.self)
        #endif
    }
}
