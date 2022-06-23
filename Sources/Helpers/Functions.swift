import UIKit
import AVFoundation

func imageNamed(_ name: String) -> UIImage {
    let cls = BarcodeScannerViewController.self
    var bundle = Bundle(for: cls)
    let traitCollection = UITraitCollection(displayScale: 3)
    
    if let resourceBundle = bundle.resourcePath.flatMap({ Bundle(path: $0 + "/BarcodeScanner.bundle") }) {
        bundle = resourceBundle
    }
    
    guard let image = UIImage(named: name, in: bundle, compatibleWith: traitCollection) else {
        return UIImage()
    }
    
    return image
}

/**
 Returns localized string using localization resource bundle.
 - Parameter name: Image name.
 - Returns: An image.
 */
func localizedString(_ key: String) -> String {
    if let path = Bundle(for: BarcodeScannerViewController.self).resourcePath,
       let resourceBundle = Bundle(path: path + "/Localization.bundle") {
        return resourceBundle.localizedString(forKey: key, value: nil, table: "Localizable")
    }
    return key
}
/**
 Returns image with a given name from the resource bundle.
 - Parameter name: Image name.
 - Returns: An image.
 */
func imageNamed_old(_ name: String) -> UIImage {
    let traitCollection = UITraitCollection(displayScale: 3)
    
    guard let image = UIImage(named: name, in: Bundle.module, compatibleWith: traitCollection) else {
        return UIImage()
    }
    
    return image
}

/**
 Returns localized string using localization resource bundle.
 - Parameter name: Image name.
 - Returns: An image.
 */
func localizedString_old(_ key: String) -> String {
    NSLocalizedString(key, bundle: Bundle.module, comment: key)
}

/// Checks if the app is running in Simulator.
var isSimulatorRunning: Bool = {
#if swift(>=4.1)
#if targetEnvironment(simulator)
    return true
#else
    return false
#endif
#else
#if (arch(i386) || arch(x86_64)) && os(iOS)
    return true
#else
    return false
#endif
#endif
}()


import class Foundation.Bundle

private class BundleFinder {}

extension Foundation.Bundle {
    /// Returns the resource bundle associated with the current Swift module.
    static var module: Bundle = {
        let bundleName = "BarcodeScanner"

        let candidates = [
            // Bundle should be present here when the package is linked into an App.
            Bundle.main.resourceURL,

            // Bundle should be present here when the package is linked into a framework.
            Bundle(for: BundleFinder.self).resourceURL,

            // For command-line tools.
            Bundle.main.bundleURL,
        ]

        for candidate in candidates {
            let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }
        fatalError("unable to find bundle named BioSwift_BioSwift")
    }()
}
