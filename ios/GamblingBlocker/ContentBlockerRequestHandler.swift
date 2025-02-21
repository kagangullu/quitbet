import Foundation
import MobileCoreServices
import SafariServices

class ContentBlockerRequestHandler: NSObject, NSExtensionRequestHandling {
    func beginRequest(with context: NSExtensionContext) {
        let bundle = Bundle.main
        print("Bundle path: \(bundle.bundlePath)")
        
        // Tüm kaynakları listele
        let resourcePaths = Bundle.main.paths(forResourcesOfType: "json", inDirectory: nil)
        print("Found JSON files: \(resourcePaths)")
        
        guard let jsonURL = bundle.url(forResource: "blocker", withExtension: "json") else {
            print("Error: blocker.json not found in bundle")
            let error = NSError(domain: NSCocoaErrorDomain, code: 1, userInfo: [NSLocalizedDescriptionKey: "blocker.json not found"])
            context.cancelRequest(withError: error)
            return
        }
        
        print("Found JSON at path: \(jsonURL.path)")
        
        do {
            let jsonData = try Data(contentsOf: jsonURL)
            print("JSON data size: \(jsonData.count) bytes")
            
            let attachment = NSItemProvider(item: jsonData as NSData, typeIdentifier: String(kUTTypeJSON))
            let item = NSExtensionItem()
            item.attachments = [attachment]
            
            context.completeRequest(returningItems: [item], completionHandler: nil)
        } catch {
            print("Error reading JSON: \(error)")
            context.cancelRequest(withError: error)
        }
    }
}