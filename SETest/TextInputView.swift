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
      VStack(alignment: .leading) {
        HStack {
          TextField("Enter text", text: $textFieldText)
            .textFieldStyle(RoundedBorderTextFieldStyle())
          Button(action: {textFieldText = ""}) {
            Image(systemName: "xmark.circle.fill")
              .foregroundColor(.gray)
          }
          .padding(.trailing, 4)
        }
        .padding()

        Button(action: {
            staticLabelText = textFieldText
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

        HStack {
          Text("You entered: ").foregroundColor(.gray).padding(.leading, 4)
          Text(staticLabelText)
            .padding(.trailing, 4)
        }
        .padding()
      }
      .padding()
    }
}

#Preview {
  TextInputView()
}
