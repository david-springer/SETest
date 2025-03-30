//
//  ShareViewController.swift
//  SEShareExtension
//
//  Created by David Springer on 2025-03-29.
//

import SwiftUI
import UIKit
import UniformTypeIdentifiers
import SETestCommon

/// Close the share extension.
/// @param extensionContext The share extension contxt.
func closeShareExtension(_ extensionContext: NSExtensionContext) {
  extensionContext.completeRequest(returningItems: [], completionHandler: nil)
}

class ShareViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    DispatchQueue.main.async {
        // host the SwiftU view
      let contentView = UIHostingController(rootView: ShareView(extensionContext: self.extensionContext!))
        self.addChild(contentView)
        self.view.addSubview(contentView.view)

        // set up constraints
        contentView.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        contentView.view.bottomAnchor.constraint (equalTo: self.view.bottomAnchor).isActive = true
        contentView.view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        contentView.view.rightAnchor.constraint (equalTo: self.view.rightAnchor).isActive = true
    }
  }

}

struct ShareView: View {
  let extensionContext: NSExtensionContext?

  var body: some View {
    VStack {
      Button(action: {
        guard
          let context = extensionContext,
          let userDefaults = UserDefaults(suiteName: Constants.sharedAppGroupIdentifier)
        else {
          return
        }
        userDefaults.set("Hello world", forKey: Constants.sharedTextKey)
        userDefaults.synchronize()
        closeShareExtension(context)
      }) {
        Text("Hello world")
          .foregroundColor(.white)
          .padding(.horizontal, 24)
          .padding(.vertical, 12)
      }
      .background(Color.blue)
      .cornerRadius(48)
    }
  }
}
