//
//  HideKeyboardExtension.swift
//  Devote
//
//  Created by Arthur Neves on 07/12/21.
//

import SwiftUI

#if canImport(UIKit)
extension View {
  func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
#endif
