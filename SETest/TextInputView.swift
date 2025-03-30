//
//  TextInputView.swift
//  SETest
//
//  Created by David Springer on 2025-03-29.
//

import SwiftUI
import SETestCommon

struct TextInputView: View {
  @State private var textFieldText = ""
  @State private var staticLabelText = ""

  /// Stacked view that has a single-line text input field with a clear button, a Submit
  /// button and a label showing the text you most recently submitted.
  var body: some View {
    VStack(alignment: .leading) {
      // Handles entering a single line of text.
      HStack {
        TextField("Enter text", text: $textFieldText)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          // Tapping return does the same action as the submit button; the TextField only
          // allows one line of input.
          .onSubmit {
            submitText(textFieldText)
          }

        // Clear button.
        Button(action: {textFieldText = ""}) {
          Image(systemName: "xmark.circle.fill")
            .foregroundColor(.gray)
        }
        .padding(.trailing, 4)
      }
      .padding()

      // Submit button.
      Button(action: {
        submitText(textFieldText)
      }) {
        Text("Submit")
          .foregroundColor(.white)
          .padding(.horizontal, 24)
          .padding(.vertical, 12)
      }
      .background(Color.blue)
      .cornerRadius(48)
      .frame(maxWidth: .infinity, alignment: .center)  // Centre-align the button.
      .padding()

      // Most recent text entered.
      HStack {
        Text("You entered: ").foregroundColor(.gray).padding(.leading, 4)
        Text(staticLabelText)
          .padding(.trailing, 4)
      }
      .padding()
    }
    .padding()
    .onAppear() {
      synchroniseSharedText()
    }
    .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
      synchroniseSharedText()
    }

  }

  /// Handle the submit action.
  /// @param newText The text string to submit.
  func submitText(_ newText: String) -> Void {
    staticLabelText = newText
  }

  /// Synchronises with the shared text..
  func synchroniseSharedText() -> Void {
    guard
      let userDefaults = UserDefaults(suiteName: Constants.sharedAppGroupIdentifier),
      let sharedText = userDefaults.string(forKey: Constants.sharedTextKey) else {
        return
      }
    textFieldText = sharedText
    staticLabelText = sharedText
  }

}

#Preview {
  TextInputView()
}
