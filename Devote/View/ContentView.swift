//
//  ContentView.swift
//  Devote
//
//  Created by Arthur Neves on 06/12/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
  @State var task = ""
  
  private var isButtonDisabled: Bool { task.isEmpty }
  
  // MARK: - FETCHING DATA
  @Environment(\.managedObjectContext) private var viewContext
  
  @FetchRequest(
    sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
    animation: .default)
  private var items: FetchedResults<Item>
  
  var body: some View {
    NavigationView {
      VStack {
        VStack(spacing: 16) {
          TextField("New Task", text: $task)
            .padding()
            .background(
              Color(UIColor.systemGray6)
            )
            .cornerRadius(10)
          
          Button(action: {
            addItem()
          }) {
            Spacer()
            Text("SAVE")
            Spacer()
          } //: Button
          .disabled(isButtonDisabled)
          .padding()
          .font(.headline)
          .foregroundColor(.white)
          .background(isButtonDisabled ? Color.gray : Color.pink)
          .cornerRadius(10)
        } //: VStack
        .padding()
        
        List {
          ForEach(items) { item in
            VStack(alignment: .leading) {
              Text(item.task ?? "")
                .font(.headline)
                .fontWeight(.bold)
              
              Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                .font(.footnote)
                .foregroundColor(.gray)
            }
          }
          .onDelete(perform: deleteItems)
        } //: List
      } //: VStack
      .navigationBarTitle("Daily Tasks", displayMode: .large)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          EditButton()
        }
      } //: Toolbar
    } //: NavigationView
  }
  
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
    }
  }
  
  private func deleteItems(offsets: IndexSet) {
    withAnimation {
      offsets.map { items[$0] }.forEach(viewContext.delete)
      
      do {
        try viewContext.save()
      } catch {
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
    }
  }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
