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
    var body: some View {
        VStack {
          TextField("Enter text", text: $textFieldText)
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
          Text(staticLabelText)
            .padding()
          Button("Submit") {
            staticLabelText = "textFieldText"
          }
        }
        .padding()
    }
}

#Preview {
  TextInputView()
}
