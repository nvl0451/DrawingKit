//
//  ContentView.swift
//  DrawingKit
//
//  Created by Андрей Королев on 14.03.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: Drawing.entity(), sortDescriptors: []) var drawings: FetchedResults<Drawing>
    
    @State private var showSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(drawings) {drawing in
                        NavigationLink(destination: DrawingView(id: drawing.id, data: drawing.drawingData, title: drawing.title), label: {
                            Text(drawing.title ?? "Untitled")
                        })
                    }
                    .onDelete(perform: deleteItem)
                    
                    Button(action: {
                        self.showSheet.toggle()
                    }, label: {
                        HStack{
                            Image(systemName: "plus")
                            Text("New Drawing")
                        }
                    }).sheet(isPresented: $showSheet, content: {
                        AddNewDrawingView().environment(\.managedObjectContext, viewContext)
                    })
                    .foregroundColor(.blue)
                }
                .navigationTitle(Text("Drawing Kit"))
                .toolbar {
                    EditButton()
                }
                
            }
            VStack {
                Image(systemName: "scribble.variable").font(.largeTitle)
                Text("No Drawing Selected").font(.title)
            }
        }.navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
    
    func deleteItem(at offset: IndexSet) {
        for idx in offset {
            let itemToDelete = drawings[idx]
            viewContext.delete(itemToDelete)
            do {
                try viewContext.save()
            } catch {
                print(error)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
