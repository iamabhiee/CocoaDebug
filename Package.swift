// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "CocoaDebug",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "CocoaDebug", targets: ["CocoaDebug"]),
    ],
    targets: [
        .target(
            name: "CocoaDebugObjC",
            path: "Sources",
            exclude: [
                "Resources"
            ],
            sources: [
                "Categories/GPBMessage+CocoaDebug.m",
                "Categories/NSObject+CocoaDebug.m",
                "Core/CocoaDebugDeviceInfo.m",
                "Core/_AutoLaunch.m",
                "Core/_DeviceUtil+Constant.m",
                "Core/_DeviceUtil.m",
                "CustomHTTPProtocol/_CacheStoragePolicy.m",
                "CustomHTTPProtocol/_CanonicalRequest.m",
                "CustomHTTPProtocol/_CustomHTTPProtocol.m",
                "CustomHTTPProtocol/_QNSURLSessionDemux.m",
                "Logs/CocoaDebugTool.m",
                "Logs/_NSLogHook.m",
                "Logs/_OCLogHelper.m",
                "Logs/_OCLogModel.m",
                "Logs/_OCLogStoreManager.m",
                "Logs/_OCLoggerFormat.m",
                "Logs/_ObjcLog.m",
                "Monitor/_BacktraceLogger.m",
                "Monitor/_DebugConsoleLabel.m",
                "Monitor/_RunloopMonitor.m",
                "Network/_HttpDatasource.m",
                "Network/_HttpModel.m",
                "Network/_NetworkHelper.m",
                "Sandbox/_DirectoryContentsTableViewController.m",
                "Sandbox/_FileInfo.m",
                "Sandbox/_FilePreviewController.m",
                "Sandbox/_FileTableViewCell.m",
                "Sandbox/_ImageController.m",
                "Sandbox/_ImageResources.m",
                "Sandbox/_Sandboxer.m",
                "Sandbox/_SandboxerHelper.m",
                "Swizzling/_Swizzling.m",
                "Swizzling/_WKWebView+Swizzling.m",
                "fishhook/_fishhook.c"
            ],
            publicHeadersPath: ".",
            cSettings: [
                .headerSearchPath("."),
                .headerSearchPath("Categories"),
                .headerSearchPath("Core"),
                .headerSearchPath("CustomHTTPProtocol"),
                .headerSearchPath("Logs"),
                .headerSearchPath("Monitor"),
                .headerSearchPath("Network"),
                .headerSearchPath("Sandbox"),
                .headerSearchPath("Swizzling"),
                .headerSearchPath("fishhook")
            ]
        ),
        .target(
            name: "CocoaDebug",
            dependencies: [
                "CocoaDebugObjC"
            ],
            path: "Sources",
            exclude: [
                "Categories/GPBMessage+CocoaDebug.m",
                "Categories/NSObject+CocoaDebug.m",
                "Core/CocoaDebugDeviceInfo.m",
                "Core/_AutoLaunch.m",
                "Core/_DeviceUtil+Constant.m",
                "Core/_DeviceUtil.m",
                "CustomHTTPProtocol/_CacheStoragePolicy.m",
                "CustomHTTPProtocol/_CanonicalRequest.m",
                "CustomHTTPProtocol/_CustomHTTPProtocol.m",
                "CustomHTTPProtocol/_QNSURLSessionDemux.m",
                "Logs/CocoaDebugTool.m",
                "Logs/_NSLogHook.m",
                "Logs/_OCLogHelper.m",
                "Logs/_OCLogModel.m",
                "Logs/_OCLogStoreManager.m",
                "Logs/_OCLoggerFormat.m",
                "Logs/_ObjcLog.m",
                "Monitor/_BacktraceLogger.m",
                "Monitor/_DebugConsoleLabel.m",
                "Monitor/_RunloopMonitor.m",
                "Network/_HttpDatasource.m",
                "Network/_HttpModel.m",
                "Network/_NetworkHelper.m",
                "Sandbox/_DirectoryContentsTableViewController.m",
                "Sandbox/_FileInfo.m",
                "Sandbox/_FilePreviewController.m",
                "Sandbox/_FileTableViewCell.m",
                "Sandbox/_ImageController.m",
                "Sandbox/_ImageResources.m",
                "Sandbox/_Sandboxer.m",
                "Sandbox/_SandboxerHelper.m",
                "Swizzling/_Swizzling.m",
                "Swizzling/_WKWebView+Swizzling.m",
                "fishhook/_fishhook.c"
            ],
            sources: [
                "App/AboutViewController.swift",
                "App/AppInfoViewController.swift",
                "App/CrashCell.swift",
                "App/CrashDetailViewController.swift",
                "App/CrashListViewController.swift",
                "App/CrashLogger.swift",
                "App/CrashStoreManager.swift",
                "App/IgnoredURLsViewController.swift",
                "App/_CrashModel.swift",
                "Core/CocoaDebug+Extensions.swift",
                "Core/CocoaDebug.swift",
                "Core/CocoaDebugSettings.swift",
                "Logs/LogCell.swift",
                "Logs/LogViewController.swift",
                "Logs/_SwiftLogHelper.swift",
                "Monitor/FPSCounter.swift",
                "Network/JsonViewController.swift",
                "Network/NetworkCell.swift",
                "Network/NetworkDetailCell.swift",
                "Network/NetworkDetailModel.swift",
                "Network/NetworkDetailViewController.swift",
                "Network/NetworkViewController.swift",
                "Window/Bubble.swift",
                "Window/CocoaDebugNavigationController.swift",
                "Window/CocoaDebugTabBarController.swift",
                "Window/CocoaDebugViewController.swift",
                "Window/CocoaDebugWindow.swift",
                "Window/Color.swift",
                "Window/UIBlockingBubble.swift",
                "Window/WindowHelper.swift"
            ],
            resources: [
                .process("Resources")
            ]
        )
    ],
    swiftLanguageVersions: [.v5]
)
