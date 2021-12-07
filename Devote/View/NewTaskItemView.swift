//
//  NewTaskItemView.swift
//  Devote
//
//  Created by Arthur Neves on 07/12/21.
//

import SwiftUI

struct NewTaskItemView: View {
  @AppStorage("isDarkMode") private var isDarkMode = false
  @Environment(\.managedObjectContext) private var viewContext
  @State private var task = ""
  @Binding var isShowing: Bool
  
  private var isButtonDisabled: Bool { task.isEmpty }
  
  // MARK: - FUNCTION
  private func addItem() {
    withAnimation {
      let newItem = Item(context: viewContext)
      newItem.timestamp = Date()
      newItem.task = task
      newItem.completion = false
      newItem.id = UUID()
      
      do {
        try viewContext.save()
      } catch {
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
      
      task = ""
      hideKeyboard() //UIKit extension
      isShowing = false
    }
  }
  
  var body: some View {
    VStack {
      Spacer()
      
      VStack(spacing: 16) {
        TextField("New Task", text: $task)
          .foregroundColor(.pink)
          .font(.system(size: 24, weight: .bold, design: .rounded))
          .padding()
          .background(
            isDarkMode ? Color(UIColor.tertiarySystemBackground) : Color(UIColor.secondarySystemBackground)
          )
          .cornerRadius(10)
        
        Button(action: {
          addItem()
        }) {
          Spacer()
          Text("SAVE")
            .font(.system(size: 24, weight: .bold, design: .rounded))
          Spacer()
        } //: Button
        .disabled(isButtonDisabled)
        .padding()
        .foregroundColor(.white)
        .background(isButtonDisabled ? Color.gray : Color.pink)
        .cornerRadius(10)
      } //: VStack
      .padding(.horizontal)
      .padding(.vertical, 20)
      .background(
        isDarkMode ? Color(UIColor.secondarySystemBackground) : Color.white
      )
      .cornerRadius(16)
      .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.65), radius: 24)
      .frame(maxWidth: 640)
    } //: Vstack
    .padding()
  }
}

struct NewTaskItemView_Previews: PreviewProvider {
  static var previews: some View {
    NewTaskItemView(isShowing: .constant(true))
      .background(Color.gray.edgesIgnoringSafeArea(.all))
  }
}
