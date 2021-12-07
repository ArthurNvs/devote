//
//  CheckboxStyle.swift
//  Devote
//
//  Created by Arthur Neves on 07/12/21.
//

import SwiftUI

struct CheckboxStyle: ToggleStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
        .foregroundColor(configuration.isOn ? .pink : .primary)
        .font(.system(size: 30, weight: .semibold, design: .rounded))
        .onTapGesture {
          configuration.isOn.toggle()
        }
      
      configuration.label
    } //: HStack
  }
}

struct CheckboxStyle_Previews: PreviewProvider {
  static var previews: some View {
    Toggle("Placeholder laber", isOn: .constant(true))
      .toggleStyle(CheckboxStyle())
      .padding()
      .previewLayout(.sizeThatFits)
  }
}
