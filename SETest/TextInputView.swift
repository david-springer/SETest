//
//  TextInputView.swift
//  SETest
//
//  Created by David Springer on 2025-03-29.
//

import SwiftUI

struct TextInputView: View {
  @State private var textFieldText = ""
  @State private var staticLabelText = ""
  @AppStorage("savedText") private var savedText = ""

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
          .onAppear() {
            textFieldText = savedText
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
          .onAppear() {
            staticLabelText = savedText
          }
      }
      .padding()
    }
    .padding()
  }

  /// Handle the submit action.
  /// @param newText The text string to submit.
  func submitText(_ newText: String) -> Void {
    staticLabelText = newText
    savedText = newText
  }

}

#Preview {
  TextInputView()
}
