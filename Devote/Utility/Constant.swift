//
//  Constant.swift
//  Devote
//
//  Created by Arthur Neves on 07/12/21.
//

import SwiftUI

// MARK: - FORMATTER
let itemFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateStyle = .short
  formatter.timeStyle = .medium
  return formatter
}()

// MARK: - UI
var backgroundGradient: LinearGradient {
  LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
}

// MARK: - UX
