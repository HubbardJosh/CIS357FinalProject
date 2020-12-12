//
//  ContentView.swift
//  Randomizer
//
//  Created by Josh Hubbard on 12/11/20.
//

import SwiftUI

struct Item: Identifiable {
    var id: Int
    
    var item: String
    var count: Int
}

struct ItemRow: View {
    var rowItem: Item
    
    var body: some View {
        Text(rowItem.item)
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView: View {
    @State var items = [Item]()
    @State var enteredText = ""
    @State var idCount = 0
    @State var displayArray = [Item]()
    
    var accentColor = Color(Color.RGBColorSpace.sRGB, red: 0.3, green: 0.5, blue: 0.7, opacity: 1.0)
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            HStack() {
                TextField("Enter text here", text: $enteredText)
                    .padding(.all, 10.0)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Save/Load") {
                    saveLoad()
                }
                .padding(.all, 10.0)
                .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(accentColor)
                .foregroundColor(Color(UIColor.lightText))
                .font(.caption)
                .cornerRadius(4)
                
            }
            .padding(.all, 10.0)
            
            List(items) { item in
                Text(item.item)
            }
            .padding([.bottom, .trailing], 10.0)
            
            Button("Enter"){
                if enteredText != "" {
                    enterButtonAction(addText: self.enteredText)
                }
                self.enteredText = ""
                UIApplication.shared.endEditing()
            }
            .padding(.all, 10.0)
            .frame(width: UIScreen.main.bounds.size.width - 30, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(accentColor)
            .foregroundColor(Color(UIColor.lightText))
            .font(.caption)
            .cornerRadius(4)
            
            
            HStack {
                Button("Choose") {
                    choose1ButtonAction()
                }
                .padding(.all, 10.0)
                .frame(width: (UIScreen.main.bounds.size.width - 45) / 3.0, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(accentColor)
                .foregroundColor(Color(UIColor.lightText))
                .font(.caption)
                .cornerRadius(4)
                
                Button("Choose x5") {
                    choose5ButtonAction()
                }
                .padding(.all, 10.0)
                .frame(width: (UIScreen.main.bounds.size.width - 45) / 3.0, height: 50, alignment: .center)
                .background(accentColor)
                .foregroundColor(Color(UIColor.lightText))
                .font(.caption)
                .cornerRadius(4)
                
                Button("Choose x10") {
                    choose10ButtonAction()
                }
                
                .padding(.all, 10.0)
                .frame(width: (UIScreen.main.bounds.size.width - 45) / 3.0, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(accentColor)
                .foregroundColor(Color(UIColor.lightText))
                .font(.caption)
                .cornerRadius(4)
            }
            
            
        }
        .padding(.bottom, 15.0)
        
    }
            
            
            
            
            
            
            
            
            
            
//              // textfield and save/load button at top
//            TextField("Enter text here",
//                      text: $enteredText,
//                      onCommit:  {
//
//                        items.append(Item(id: 0, item: enteredText, count: 0))
//
//                      }
//            )
//            .navigationBarItems(trailing:
//                                    List(items) { i in
//                                        ItemRow(rowItem: i)
//                                    }
//            )
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding(10)
//
//            Button("Save/Load", action: {saveLoad()})
//          }
//          VStack() {
//              // tableview and label above enter button
//
//
//          }
//          VStack() {
//              // enter button
////            Button ("Enter", action: {enterButtonAction()})
//              HStack() {
//                  // choose buttons
//                Button ("Choose x1", action: {choose1ButtonAction()})
//                Button ("Choose x5", action: {choose5ButtonAction()})
//                Button ("Choose x10", action: {choose10ButtonAction()})
//              }
//              // clear button
//            Button ("Clear", action: {clearButtonAction()})
//          }
//      }
    
    func restoreArrayValues(list: [Item]) {
        items = list
    }
    func choose1ButtonAction() {
        if items.count > 0 {
            restoreArrayValues(list: displayArray)
            let chosen = items.randomElement()?.item
            for x in 0..<items.count {
                if items[x].item == chosen {
                    items[x].item = "\(items[x].item) ☆"
                }
            }
            
            print(items.randomElement()!)
        }
        
        
    }
    func choose5ButtonAction() {    // this doesn't work yet
        if items.count > 0 {
            items = displayArray
            var chosenItem = items.randomElement()
            for _ in 0..<5 {
                chosenItem = items.randomElement()
                for x in 0..<items.count {
                    if chosenItem?.item == items[x].item {
                        items[x].count += 1
                    }
                }
            }
            
            for item in 0..<items.count {
                items[item].item = "\(items[item].item): \(items[item].count)"
            }
//            print(items.randomElement()!)
        }
        
    }
    func choose10ButtonAction() {
        if items.count > 0 {
            print(items.randomElement()!)
        }
        
    }
    func clearButtonAction() {
        print("clear")
        items.removeAll()
    }
    func saveLoad() {
        
        print("save/load")
    }
    func enterButtonAction(addText: String) {
        restoreArrayValues(list: displayArray)
        items.append(Item(id: idCount, item: addText, count: 0))
        displayArray.append(Item(id: idCount, item: addText, count: 0))
        idCount += 1
        print("enter")
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
