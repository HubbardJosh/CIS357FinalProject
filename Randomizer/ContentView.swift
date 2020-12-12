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
            .listRowBackground(Color(Color.RGBColorSpace.sRGB, red: 0.9, green: 0.9, blue: 0.9, opacity: 1.0))
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
    
    let accentColor = Color(Color.RGBColorSpace.sRGB, red: 0.3, green: 0.5, blue: 0.7, opacity: 1.0)
    let textColor = Color(Color.RGBColorSpace.sRGB, red: 0.9, green: 0.9, blue: 0.9, opacity: 1.0)
    var body: some View {
        
        
        
        ZStack {
            textColor
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 10) {
                HStack() {
                    TextField("Enter text here", text: $enteredText)
                        .padding(.all, 5.0)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .ignoresSafeArea()
                        .background(textColor)
                    
                    Button("Save/Load") {
                        saveLoad()
                    }
                    .padding(.all, 10.0)
                    .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(accentColor)
                    .foregroundColor(textColor)
                    .font(Font.caption.weight(.heavy))
                    .cornerRadius(4)
                    
                }
                .padding(.all, 10.0)
                
                List(items) { item in
                    Text(item.item)
                }
                .padding([.bottom, .trailing], 10.0)
                .background(textColor)
                .listRowBackground(textColor)
                
                HStack {
                    Button(action: {            // enter button
                        if enteredText != "" {
                            enterButtonAction(addText: self.enteredText)
                        }
                        self.enteredText = ""
                        UIApplication.shared.endEditing()
                    }) {
                        Text("Enter")
                            .lineLimit(2)
                            .multilineTextAlignment(.center)
                            .frame(width: UIScreen.main.bounds.size.width - 30, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .background(accentColor)
                            .foregroundColor(textColor)
                            .font(Font.caption.weight(.heavy))
                            .cornerRadius(4)
                    }
                }
                
                
                HStack {
                    HStack {
                        Button(action: {            // choose 1 button
                            choose1ButtonAction()
                        }) {
                            Text("Choose x1")
                                .padding(.all, 10.0)
                                .frame(width: (UIScreen.main.bounds.size.width - 45) / 3.0, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .background(accentColor)
                                .foregroundColor(textColor)
                                .font(Font.caption.weight(.heavy))
                                .cornerRadius(4)
                        }
                    }
                    HStack {
                        Button(action: {            // choose 5 button
                            choose5ButtonAction()
                        }) {
                            Text("Choose x5")
                                .padding(.all, 10.0)
                                .frame(width: (UIScreen.main.bounds.size.width - 45) / 3.0, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .background(accentColor)
                                .foregroundColor(textColor)
                                .font(Font.caption.weight(.heavy))
                                .cornerRadius(4)
                        }
                    }
                    HStack {
                        Button(action: {            // choose 10 button
                            choose10ButtonAction()
                        }) {
                            Text("Choose x10")
                                .padding(.all, 10.0)
                                .frame(width: (UIScreen.main.bounds.size.width - 45) / 3.0, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .background(accentColor)
                                .foregroundColor(textColor)
                                .font(Font.caption.weight(.heavy))
                                .cornerRadius(4)
                        }
                    }
                }
                .padding(.horizontal, 10.0)
                
                HStack {
                    Button(action: {            // choose 10 button
                        clearButtonAction()
                    }) {
                        Text("Clear")
                            .padding(.all, 10.0)
                            .frame(width: UIScreen.main.bounds.size.width - 30, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .background(accentColor)
                            .foregroundColor(textColor)
                            .font(Font.caption.weight(.heavy))
                            .cornerRadius(4)
                    }
                }
            }
        }
    }
    
    
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
                items[item].item = "\(items[item].item): Chosen \(items[item].count) times"
            }
        }
        
    }
    func choose10ButtonAction() {
        if items.count > 0 {
            items = displayArray
            var chosenItem = items.randomElement()
            for _ in 0..<10 {
                chosenItem = items.randomElement()
                for x in 0..<items.count {
                    if chosenItem?.item == items[x].item {
                        items[x].count += 1
                    }
                }
            }
            
            for item in 0..<items.count {
                items[item].item = "\(items[item].item): Chosen \(items[item].count) times"
            }
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
