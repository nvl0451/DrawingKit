//
//  AddNewDrawingView.swift
//  DrawingKit
//
//  Created by Андрей Королев on 14.03.2022.
//

import SwiftUI

struct AddNewDrawingView: View {
    
    @Environment (\.managedObjectContext) var viewContext
    @Environment (\.presentationMode) var presentationMode
    
    @State private var drawingTitle = ""
    
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Drawing title", text: $drawingTitle)
                }
            }
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
                
            }),
            trailing: Button(action: {
                if !drawingTitle.isEmpty {
                    let drawing = Drawing(context: viewContext)
                    drawing.title = drawingTitle
                    drawing.id = UUID()
                    
                    do {
                        try viewContext.save()
                    } catch {
                        print(error)
                    }
                    
                    self.presentationMode.wrappedValue.dismiss()
                }
            }, label: {
                Text("Save")
            }))
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationTitle(Text("Add New Drawing"))
        }
    }
}

struct AddNewDrawingView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewDrawingView()
    }
}
